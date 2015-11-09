sync repos
  - from a text list of remotes

create content view
  - create container directory
  - create text file listing sync'd repos to include

parse content view (text file)
  - create library directory in view
    - create sub dirs per repo
    - create text file listing of each repo (rpms) at that moment in time
    - parse text file to create symlinks
    - run createrepo

versioning a view
  - create a directory in the view
  - copy the library text file
  - parse text file to create symlinks (or copy the symlinks - requires locking)
  - run createrepo (or copy from library - requires locking)

environments
  - text file in the directory defines the names and sequence of flow
  - text files to record currently deployed versions per flow item

promotion
  - update environment text file with view version
  - parse text file to create symlink to the view version named as the next flow item
  - flow goes one way only, can't skip a level


backup
  - all the text files

recovery
  - sync repos
  - create all stuff from text files (should be able to blast all symlinks and recreate from these)

to consider
  - copying symlinks and repo data should be quicker than recreating, but doesn't lend it self to a rebuild
  - limit repo contents to X previous versions to limit meta data size?
