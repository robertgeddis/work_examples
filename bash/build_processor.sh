# Automated build processing script
#!/bin/bash
echo "Welcome to the bash script"

# 1. Get the version from the first line of the changelog
# Assumes changelog.md starts with something like: "Version 1.2.3 ..."
firstline=$(head -n 1 source/changelog.md)
read -a splitfirstline <<< "$firstline"
version=${splitfirstline[1]}

echo "You are building version $version"
echo 'Do you want to continue? (enter "1" for yes, "0" for no)'
read versioncontinue

# 2. Check user input
if [ "$versioncontinue" -eq 1 ]
then 
  echo "OK"
  
  # Ensure the build directory exists
  mkdir -p build

  # 3. Loop through files in the source directory
  for filename in source/*
  do
    if [ "$filename" == "source/secretinfo.md" ]
    then
      echo "Not copying $filename"
    else
      echo "Copying $filename"
      cp "$filename" build/
    fi
  done  

  # 4. Move into the build directory to verify
  cd build/
  echo "Build version $version contains:"
  ls
  cd ..
  
else 
  echo "Please come back when you are ready"
fi
