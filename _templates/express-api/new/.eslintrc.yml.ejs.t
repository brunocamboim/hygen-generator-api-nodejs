---
to: ../<%= folderName %>/.eslintrc.yml
---
env:
  commonjs: true
  es6: true
extends: 'eslint:recommended'
globals:
  Atomics: readonly
  SharedArrayBuffer: readonly
  process: readonly
  describe: readonly
  it: readonly
  setTimeout: readonly
parserOptions:
  ecmaVersion: 9
  ecmaFeatures:
    globalReturn: true
    spread: true
rules:
  indent:
    - error
    - 2
    - SwitchCase: 1
  quotes:
    - error
    - single
  semi:
    - error
    - always
  prefer-const:
    - error
    - destructuring: any
      ignoreReadBeforeAssign: false
