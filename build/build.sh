#!/bin/bash

PYTHON=python3.9

typehint() {
  mypy --ignore-missing-imports src/
}

test() {
  pytest tests/
}

lint() {
  pylint src/
}

checklist() {
  lint
  typehint
  test
}

black() {
  black -l 79 *.py
}

clean() {
  find . -type f -name "*.pyc" | xargs rm -fr
  find . -type d -name __pycache__ | xargs rm -fr
}

# if build.sh is called without arguments, print the argument list and exit
case "$1" in
  typehint)
    typehint
    ;;
  test)
    test
    ;;
  lint)
    lint
    ;;
  checklist)
    checklist
    ;;
  black)
    black
    ;;
  clean)
    clean
    ;;
  *)
    echo "Usage: $0 {typehint|test|lint|checklist|black|clean}"
    exit 1
esac
