nix-instantiate --eval --strict --quiet --json dev/_get-docs.nix \
  | jq \
  | sed 's/^  },$/  },\n/' \
  | sed 's/\\n"/"/' \
  | sed -r 's/(\\n)+/ /g'
