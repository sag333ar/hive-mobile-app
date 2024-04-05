echo "fetching all tags ..."

git fetch --tags

echo "done fetching all tags"

lastversionandbuildnumber=`git tag -l | tail -1`
lastversion=`echo $lastversionandbuildnumber | cut -d "+" -f 1`
lastbuildnumber=`echo $lastversionandbuildnumber | cut -d "+" -f 2`

echo "last version  is $lastversionandbuildnumber"

newbuildnumber=`expr $lastbuildnumber + 1`

line="version:.*"
rep="version: $lastversion+$newbuildnumber"

echo "new version $lastversion+$newbuildnumber"

sed -e "s/${line}/${rep}/g" pubspec.yaml > pubspec-new.yaml

mv pubspec-new.yaml pubspec.yaml

echo "Building project ..."

# flutter build web --web-renderer html
flutter build web --web-renderer html -t lib/main.dart --no-tree-shake-icons

echo "Deploying project ..."

firebase deploy

git add pubspec.yaml

git commit -m "version bumped to $lastversion+$newbuildnumber"

echo "Adding tag on Git ..."

git tag "$lastversion+$newbuildnumber"

echo "Pushing tag on Git ..."

git push --tags

git push

echo "Done"