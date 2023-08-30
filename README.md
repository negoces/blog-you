# hugo-blog-md-you

## 文件结构

```bash
layouts                     # 页面布局
    _default                # 默认模板
        baseof.html         # 基础模板，凡是定义了 {{ define "xxx" }} 都会使用此模板
    index.html              # index 模板
script                      # 脚本工具
    hugo.sh                 # 下载和构建脚本
config.yaml                 # 站点配置
```
