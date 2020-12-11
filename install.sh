#/bin/sh

DEST=$HOME # can be whatever directory if you wanna debug

install_cp() {
  if [ -f $1 ]
  then
    cp $1 test
  fi

  if [ -d $1 ]
  then
    rsync --recursive $1 $DEST/$1
  fi
}

install_ln() {
  ln -sf $(pwd)/$1 $DEST/$1
}

for file in * .[^.]*
do
  if [ "$file" = "$DEST" ]; then continue; fi
  if [ "$file" = ".git" ]; then continue; fi
  if [ "$file" = ".gitmodules" ]; then continue; fi
  if [ "$file" = ".gitignore" ]; then continue; fi
  if [ "$file" = "install.sh" ]; then continue; fi
  if [ "$file" = "README.md" ]; then continue; fi

  if [ -e "$DEST/$file" ]
  then
    echo "$file exists..."
    if [ -s "$DEST/$file" ] && [ ! -d "$DEST/$file" ]
    then
      echo "Not installing it."
    else
      install_ln $file
      echo "Installing it anyway, it was empty."
    fi
    echo
  else
    install_ln $file
    echo "Installed $file."
  fi
done
