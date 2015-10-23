#!/bin/bash

create_symlinks () {

  PURGE="${PURGE:-false}"
  SOURCE="${SOURCE}"
  TARGET="${TARGET}"
  MATCH="${MATCH:-*.rpm}"

  for CHECK in SOURCE TARGET PURGE MATCH; do
    [ -z "${!CHECK}" ] && { echo Missing ${CHECK} ; return 1 ; }
  done

  mkdir -p "${TARGET}" || return 1

  if [ "${PURGE}" = true ] ; then eval rm -f "${TARGET}/${MATCH}" ; fi
  find "${SOURCE}" -maxdepth 1 -type f -name "${MATCH}" -exec ln -sf "{}" "${TARGET}" ';' 
  unset SOURCE TARGET MATCH PURGE
}

create_list () {

  SOURCE="${SOURCE}"
  TARGET="${TARGET:-${SOURCE}/_listing}"
  MATCH="${MATCH:-*.rpm}"

  find "${SOURCE}" -maxdepth 1 ! -type d -name "${MATCH}" -print | sed 's .*/  g' | sort > "${TARGET}"

  unset SOURCE TARGET MATCH

}


PURGE=true SOURCE=/tmp/repo  TARGET=${SOURCE}_links create_symlinks || exit 1
           SOURCE=/tmp/repo1 TARGET=${SOURCE}_links create_symlinks || exit 1

SOURCE=/tmp/repo_links  create_list || exit 1
SOURCE=/tmp/repo1_links create_list || exit 1
