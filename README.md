MK_iOSSamples
=============
・githubリポジトリ作成（+Readme）

・個別リポジトリ
git init

git remote add origin https://github.com/moonkids/MK_xxx.git

git add .

git fetch

git merge origin/master

git mergetool

git commit -m 'initialize'

git push origin master

・マージリポジトリ
git  submodule  add https://github.com/moonkids/MK_xxx.git MK_xxx

git commit -m 'merge'
