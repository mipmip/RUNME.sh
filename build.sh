#!/usr/bin/env bash
#(C)2019-2026 Pim Snel - https://github.com/mipmip/RUNME.sh

set -euo pipefail
cd "$(dirname "$0")"

outfile="./RUNME.sh"

echo "#!/usr/bin/env bash" > "$outfile"
echo "#(C)2019-2026 Pim Snel - https://github.com/mipmip/RUNME.sh" >> "$outfile"
cat ./src/RUNME.inc.sh | bash ./src/minify.sh >> "$outfile"
cat ./src/RUNME.tpl.sh >> "$outfile"
chmod +x "$outfile"

echo "Built $outfile"
