# Git 使用指南

## 状态

![img](https://github.com/nannanIT/MyGitCode/blob/master/MyGitCode/Resource/git.jpg)

* **untracked:** 未跟踪状态， 此文件在文件夹， 但并没有加入到git库, 不参与版本控制，通过 `git add` 将状态变为 **staged**；

* **unmodify**: 文件已经入库，未修改。如果它被修改, 而变为**modified**；如果使用`git rm`移出版本库, 则成为**Untracked**文件；

* **modified**: 文件已修改，仅仅是修改，并没有进行其它的操作。通过`git add` 可进入暂存 **staged** 状态；使用 `git checkout` . 则丢弃修改过，返回到**unmodify**状态，这个 `git checkout` 即从库中取出文件，覆盖当前修改；

* **staged**: 暂存状态。执行 `git commit` 则将修改同步到库中, 这时库中的文件和本地文件变为一致，文件为**unmodified**状态。执行 `git reset HEAD^` 取消暂存，文件状态为**modified**。

工作区、缓存区、仓库

* Changes to be committed:

   (use "git reset HEAD <file>..." to unstage)

  

  ​	modified:  hello.file

  

  Changes not staged for commit:

   (use "git add <file>..." to update what will be committed)

   (use "git checkout -- <file>..." to discard changes in working directory)

  

  ​	modified:  hello.file

  

  Untracked files:

   (use "git add <file>..." to include in what will be committed)

  

  ​	hello.file

  

## 常用命令

* 交互式终端模式

  ```bash
  git add -i
  
  *** Commands ***
    1: status	  2: update	  3: revert	  4: add untracked
    5: patch	  6: diff	  7: quit	  8: help
  ```

  交互式暂存，将暂存的修改列在左侧，未暂存的修改列在右侧。

* 同步

  ```bash
  git pull = git fetch + git merge FETCH_HEAD 
  git pull --rebase =  git fetch + git rebase FETCH_HEAD 
  ```

```bash
       D---E test
      /
 A---B---C---F--- master
```

在master执行git merge test,然后会得到如下结果：

```bash
       D--------E
      /          \
 A---B---C---F----G---   test, master
```

在master执行git rebase test，然后得到如下结果：

```bash
A---B---D---E---C‘---F‘---   test, master
```

* stash

  ```bash
  git stash -p
  ```

  Stash this hunk [y,n,q,a,d,e,?]? 
  y - stash this hunk
  n - do not stash this hunk
  q - quit; do not stash this hunk or any of the remaining ones
  a - stash this hunk and all later hunks in the file
  d - do not stash this hunk or any of the later hunks in the file
  e - manually edit the current hunk
  ? - print help

* reset操作

  ```bash
  git reset --soft HEAD^	//撤销commit 不撤销add，代码保留
  git reset HEAD^ 				//默认 撤销commit，撤销add，代码保留
  git reset --hard HEAD^ 	//撤销commit，撤销add，代码不保留
  ```

* add

  ```console
  git add --all == git add -A //将所有的已跟踪的文件的修改与删除和新增的未跟踪的文件都添加到暂存区
  git add .		// 默认，将修改操作的文件和未跟踪新添加的文件添加到git系统的暂存区，注意不包括删除的文件
  git add -u	// 将已跟踪文件中的修改和删除的文件添加到暂存区，不包括新增加的文件
  ```

  - 跟踪新文件
  - 把已跟踪的文件放到暂存区
  - 合并时把有冲突的文件标记为已解决状态

* commit

  ```bash
  git commit -m			//提交暂存区的文件
  git commit -a -m	//提交已跟踪的文件，省略 git add 操作
  ```

*  常用缩写

  ```bash
  gcam='git commit -a -m'
  gco='git checkout'
  gcb='git checkout -b'
  gcm='git checkout master'
  gup='git pull --rebase'
  gpsup='git push --set-upstream origin $(git_current_branch)' // 把一个新分支提交到远程
  ```

* revert

  在提交到远程库之前使用`git reset` 命令撤销操作，如果操作已经提交到远程库，那就使用 `git revert` 来提交一个新的撤销操作，撤销需要撤销的那次`commit`。
  
  * cherry-pick
  出现冲突后git add 再执行 git cherry-pick --continue
  --abort 停止本次操作，放弃合并
  
  
git merge BranchA     BranchB 如果BranchB是当前分支，可以省略
git merge origin/master     合并origin/master到当前分支
git merge origin 一般不会这么用，错误的使用


1、origin的含义
origin 是默认的远程版本仓库名称
可以在 .git/config 之中进行修改
事实上 git push origin master 的意思是 git push origin master:master （将本地的 master 分支推送至远端的 master 分支，如果没有就新建一个）


2、git pull=git fetch + git merge
git pull --rebase=git fetch+git rebase

3、git push origin master

Form github:

Use git push to push commits made on your local branch to a remote repository.

The git push command takes two arguments:

A remote name, for example, origin
A branch name, for example, master
For example:

git push  <REMOTENAME> <BRANCHNAME> 
As an example, you usually run $ git push origin master to push your local changes to your online repository.

新分支还没有关联远程仓库
git push --set-upstream origin branch

To push the current branch and set the remote as upstream, use

    git push --set-upstream origin feature/jay_git_test
    
    
    建立本地仓库和远程仓库之间的连接
    git branch --set-upstream-to=origin/feature/jay_source_exchange_new feature/jay_git_test
    Branch 'feature/jay_git_test' set up to track remote branch 'feature/jay_source_exchange_new' from 'origin'.
    
    
    fatal: The upstream branch of your current branch does not match
    the name of your current branch.  To push to the upstream branch
    on the remote, use

// 将当前分支push到远程的分支，HEAD是当前分支
        git push origin HEAD:feature/jay_source_exchange_new

    To push to the branch of the same name on the remote, use

// 将当前分支push到远程分支，用当前分支名
        git push origin HEAD /// 只同步到远程分支，不建立连接
        git push -u origin HEAD /// 同步到远程分支，同时建立连接
