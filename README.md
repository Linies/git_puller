## **Git自动拉取配置清单中远程库**

### 使用说明：

 配置在根目录下的配置文件以remote.yaml名称命名，以下格式定义对应目录下仓库地址和分支。

```yaml
host: "git@github.com:XXX"
projects:
  -
    name: "remote"
    library:
      -
        repo: "xxx_1.git"
        name: "xxx_1"
        branch: "main"
      -
        repo: "xxx_2.git"
        name: "xxx_2"
        branch: "main"
      -
        repo: "xxx_3.git"
        name: "xxx_3"
        branch: "main"

```



