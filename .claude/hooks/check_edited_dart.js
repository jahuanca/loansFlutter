#!/usr/bin/env node
// Hook PostToolUse: corre DESPUÉS de que Claude edita/crea un archivo (Edit, Write o MultiEdit).
//
// Cómo funciona un hook "command":
//   1. Claude Code ejecuta este script y le pasa por stdin un JSON con el evento,
//      por ejemplo: { "hook_event_name": "PostToolUse", "tool_name": "Edit",
//                     "tool_input": { "file_path": "D:/.../lib/src/x.dart", ... }, "cwd": "..." }
//   2. El script decide qué revisar y termina con un código de salida:
//        exit 0 -> todo bien, Claude sigue sin enterarse (no molesta).
//        exit 2 -> "bloqueo": lo que escribamos en stderr se le muestra a Claude
//                  para que corrija el error en el siguiente paso.
//        otro   -> error no bloqueante: solo se ve en modo verbose (ctrl+o).
//
// Qué revisa aquí: `dart analyze` SOLO del archivo .dart tocado (mucho más rápido que
// `flutter analyze` del proyecto entero). Falla con errores o warnings, igual que el CI
// (`--no-fatal-infos`). Se salta los *.g.dart (generados por build_runner).
//
// Está escrito en Node (y no en bash) para que funcione igual en Windows y en Linux.

const { spawnSync } = require('child_process')
const fs = require('fs')
const path = require('path')

const readStdin = () => {
  try {
    return fs.readFileSync(0, 'utf8')
  } catch {
    return ''
  }
}

const run = (cmd, args, cwd) =>
  spawnSync(cmd, args, {
    cwd,
    encoding: 'utf8',
    // En Windows `fvm` y `dart` son .bat/.exe en el PATH: necesitan shell.
    shell: process.platform === 'win32',
    timeout: 90_000
  })

// Usa fvm si está instalado (versión fijada en .fvmrc); si no, el `dart` del PATH (CI, nube).
const dartCommand = (cwd) => {
  const fvm = run('fvm', ['--version'], cwd)
  if (fvm.status === 0) return { cmd: 'fvm', prefix: ['dart'] }
  const dart = run('dart', ['--version'], cwd)
  if (dart.status === 0) return { cmd: 'dart', prefix: [] }
  return null
}

const tail = (text, lines = 40) => text.split('\n').slice(-lines).join('\n')

const main = () => {
  let event = {}
  try {
    event = JSON.parse(readStdin() || '{}')
  } catch {
    process.exit(0)
  }

  const filePath = event.tool_input && event.tool_input.file_path
  if (!filePath || !filePath.endsWith('.dart') || filePath.endsWith('.g.dart')) process.exit(0)

  const projectDir = process.env.CLAUDE_PROJECT_DIR || event.cwd || process.cwd()
  const relative = path.relative(projectDir, filePath).split(path.sep).join('/')
  if (!/^(lib|test)\//.test(relative)) process.exit(0)
  if (!fs.existsSync(filePath)) process.exit(0)

  const dart = dartCommand(projectDir)
  if (!dart) {
    // Sin Dart instalado no podemos revisar; avisamos sin bloquear (exit 1 = no bloqueante).
    process.stderr.write('[hook check_edited_dart] No se encontró fvm ni dart en el PATH.\n')
    process.exit(1)
  }

  const result = run(dart.cmd, [...dart.prefix, 'analyze', '--no-fatal-infos', filePath], projectDir)
  if (result.status !== 0) {
    const output = `${result.stdout || ''}${result.stderr || ''}`.trim()
    process.stderr.write(
      `[hook check_edited_dart] dart analyze encontró problemas en ${relative}:\n${tail(output)}\n\n` +
        'Corrige los errores/warnings antes de seguir.\n'
    )
    process.exit(2)
  }

  process.exit(0)
}

main()
