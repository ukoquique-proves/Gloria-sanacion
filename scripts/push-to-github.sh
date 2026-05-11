#!/usr/bin/env bash
# Empuja main usando GITHUB_TOKEN desde .env (evita conflicto nvm con PREFIX).
set -euo pipefail
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

if [[ -n "${PREFIX:-}" ]] && command -v nvm >/dev/null 2>&1; then
  unset PREFIX
fi

if [[ ! -f .env ]]; then
  echo "Falta .env. Ejecuta: cp .env.example .env y define GITHUB_TOKEN." >&2
  exit 1
fi

set -a
# shellcheck disable=SC1091
source .env
set +a

if [[ -z "${GITHUB_TOKEN:-}" ]]; then
  echo "GITHUB_TOKEN vacío en .env." >&2
  exit 1
fi

exec git push "https://ukoquique-proves:${GITHUB_TOKEN}@github.com/ukoquique-proves/Gloria-sanacion.git" main
