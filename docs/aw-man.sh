#!/usr/bin/env bash

current_opts=$(nix-instantiate --eval --strict --quiet --json ../dev/_get-docs.nix)

# Color codes
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 12)
reset=$(tput sgr0)
italics=$(tput sitm)

modname=$1

# Early exit on empty args
if [[ -z $modname ]]; then
  modules=$(echo "$current_opts" \
    | jq 'keys' \
    | tail -n +2 \
    | head -n -1 \
    | sed -r 's/^[ \t]*"//' \
    | sed -r 's/",|"//'
  )
  printf \
    "\u001b[1;4mNo module specified, current modules:\x1b[0m\n%s\n" \
    "$modules"
  exit
fi

selected_module=$(jq ".$modname" <<< "$current_opts")

# Early exit + error on invalid module name
if [[ $selected_module == "null" ]]; then
  printf \
    "aw-man: %s: No such module exists\n" \
    "$modname"
  exit 1
fi

# shellcheck disable=SC2207 # Using stackoverflow stuff
module_keys=($(jq -r "keys | @sh" <<< "$selected_module" \
  | tr -d \'\"
))

# echo "$selected_module"
# echo "${module_keys[@]}"


maininject=$(for f in "${module_keys[@]}"
do
  # shellcheck disable=SC2207
  subkeys=($(jq -r ".$f | keys | @sh" <<< "$selected_module" \
    | tr -d \'\"
  ))

  printf "\u001b[1m%s\x1b[0m\n\n" "$f"

  for i in "${subkeys[@]}"
  do
    sect=$(jq -r ".$f.$i" <<< "$selected_module")

    if [[ $i = type ]]; then
      printf "    \u001b[3m%s: \x1b[0m%s\n\n" "$i" "$sect" \
        | sed -r "s/(string|pathLike|bool)/${green}\1${reset}/" \
        | sed -r "s/(listOf|attrsOf|list|attrs)/${yellow}\1${reset}/" \
        | sed -r "s/union/${blue}union${reset}/" \
        | sed -r "s/derivation/${red}derivation${reset}/" 
    elif [[ $i = mutatorType ]]; then
      printf "    \u001b[3m%s: \x1b[0m%s\n\n" "$i" "$sect" \
        | sed -r "s/(string|pathLike|bool)/${green}\1${reset}/" \
        | sed -r "s/(listOf|attrsOf|list|attrs)/${yellow}\1${reset}/" \
        | sed -r "s/union/${blue}union${reset}/" \
        | sed -r "s/derivation/${red}derivation${reset}/"
    elif [[ $i = description ]]; then
      printf "    \u001b[3m%s:\x1b[0m\n" "$i"
      printf "%s\n\n" "$sect" \
        | sed 's/^/\t/' \
        | sed -r "s/\`(.*?)\`/${italics}\1${reset}/"
    else
      printf "    \u001b[3m%s:\x1b[0m\n" "$i"
      printf "%s\n\n" "$sect" \
        | sed 's/^/\t/'
    fi
    done
  done)

printf "\u001b[1;4m%s\x1b[0m\n\n%s" "${modname^^} - Module Options" "$maininject" | less

