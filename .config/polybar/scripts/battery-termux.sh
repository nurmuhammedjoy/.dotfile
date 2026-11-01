#!/usr/bin/env bash
# Kept for backwards compatibility; battery.sh is the real implementation.

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
exec "$script_dir/battery.sh" "$@"
