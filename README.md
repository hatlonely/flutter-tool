# flutter-tool

程序员工具集

## 部署

```shell
ops --variable .cfg/dev.yaml --env dev -a run --task image
ops --variable .cfg/dev.yaml --env dev -a run --task helm --cmd=diff
ops --variable .cfg/dev.yaml --env dev -a run --task helm --cmd=install
ops --variable .cfg/dev.yaml --env dev -a run --task helm --cmd=upgrade
```
