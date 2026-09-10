#!/usr/bin/env bash
set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")"

# Each Quarto project cleans its own output. Clear any interrupted book build
# before rendering the blog so generated book files cannot become resources.
rm -rf -- claims-data-analytics/_book
quarto render
quarto render claims-data-analytics

# Replace the complete hosted book, including assets and search, rather than
# merging it with an older build that could still contain retired pages.
rm -rf -- _book/claims-data-analytics
mv -- claims-data-analytics/_book _book/claims-data-analytics
