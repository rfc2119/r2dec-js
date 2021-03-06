#!/bin/bash
echo "Branch: $TRAVIS_BRANCH"
make --no-print-directory testbin -C p
ERRORED=$?
if [[  "$ERRORED" == "1" ]]; then
	exit $ERRORED
fi
cd ..
WORKINGDIR_TRAVIS=$(pwd)
ls r2dec-js >/dev/null 2>&1 || git clone --depth 1 https://github.com/wargio/r2dec-js
rm -rf r2dec-regression >/dev/null 2>&1 || echo "no need to clean.."
git clone --branch "$TRAVIS_BRANCH" --depth 1 https://github.com/wargio/r2dec-regression || git clone --depth 1 https://github.com/wargio/r2dec-regression
cd r2dec-regression
chmod +x testall.sh
./testall.sh "$WORKINGDIR_TRAVIS/r2dec-js" travis
ERRORED=$?
exit $ERRORED