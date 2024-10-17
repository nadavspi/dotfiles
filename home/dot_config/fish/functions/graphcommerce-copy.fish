function graphcommerce-copy
  set -l source (git rev-parse --show-toplevel)/node_modules/@graphcommerce
  pushd $source
  set -l file (fzf)
  popd
  cp $source/$file .
end
