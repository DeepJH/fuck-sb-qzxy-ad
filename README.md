# 🚫 fuck_sb_qzxy_ad

> # NEED YOUR HELP
>  目前几乎不可用，如果你有好的想法，欢迎 PR 。  
>  使用了 https://bbs.kanxue.com/thread-289254.htm#msg_header_h2_11 的规则，情况可能会好转。  
>  在此感谢作者 mb_jepgtozh 。  

**fuck_sb_qzxy_ad** 是专为“趣智校园” App 定制的 Clash 拦截规则。旨在通过精准的域名与 IP 封锁，还学生用户一个清爽、无干扰的使用体验。

> **趣智校园你妈爆炸**

---

## ✨ 核心特性

本规则经过实测，可有效拦截趣智校园及其相关生态链的绝大部分广告行为：

* ✅ **开屏广告**：启动即秒进，无需担心晃动和误触。
* ✅ **主页广告**：移除主页干扰视线的横幅与推荐广告。
* ✅ **洗澡页广告流**：拦截支付宝洗澡小程序内下方的广告。
* ✅ **流氓跳转**：封锁洗澡结束时自动跳转淘宝闪购的行为。

---

## 📖 使用指南

为了确保拦截生效，请务必按照以下步骤操作：

> 同样也提供了最基础的url，用户可以自行转换成其他格式使用（例如adguard，已添加，为adguard_rules.txt）

### 1. 自动更新链接
https://raw.githubusercontent.com/DeepJH/fuck-sb-qzxy-ad/refs/heads/main/rule-sets/clash_block.yaml

### 2. 手动加入
#### 1. 获取规则

打开本项目中的 [`clash_rules.yaml`](./rule-sets/clash_block.yaml) 文件，复制其中的全部规则。

#### 2. 修改配置

编辑你的 Clash 配置文件（通常是 `.yaml` 格式），找到 `rules:` 模块。

#### 3. 粘贴位置（重要！）

将复制的规则粘贴到 `rules:` 下方的**最前面**。

> **⚠️ 注意**：Clash 的规则匹配遵循“自上而下”原则。如果放置在末尾，可能会因为前面的 `MATCH` 或其他泛域名规则导致拦截失效。

```yaml
rules:
  # [在这里粘贴 fuck_sb_qzxy_ad 规则]
  - DOMAIN-SUFFIX,ads.example.com,REJECT 
  - ...
  # 其余原始规则
  - GEOIP,CN,DIRECT
  - MATCH,PROXY

```

### 3. 覆写脚本
```js
// 定义扩展脚本
function main(config) {
  // 1. 定义规则集 (Rule Providers)
  const adRuleProviders = {
    "fuck-sb-qzxy-ad": {
      type: "http",
      behavior: "domain",
      url: "https://raw.githubusercontent.com/DeepJH/fuck-sb-qzxy-ad/refs/heads/main/rule-sets/clash_block.yaml",
      path: "./ruleset/fuck-sb-qzxy-ad.yaml",
      interval: 86400
    },
    // 另一个优秀的广告规则，建议搭配使用
    "awavenue": {
      type: "http",
      behavior: "domain",
      url: "https://github.boki.moe/https://raw.githubusercontent.com/TG-Twilight/AWAvenue-Ads-Rule/main/Filters/AWAvenue-Ads-Rule-Clash.yaml",
      path: "./ruleset/awavenue.yaml",
      interval: 86400
    }
  };

  // 合并到配置中
  config["rule-providers"] = Object.assign({}, config["rule-providers"], adRuleProviders);

  // 2. 插入规则 (Rules)
  // 广告拦截规则通常需要放在最顶部，优先匹配
  const adRules = [
    "RULE-SET,fuck-sb-qzxy-ad,REJECT",
    "RULE-SET,reject-ads,REJECT"
  ];

  config.rules = [...adRules, ...config.rules];

  return config;
}
```
---

## ⚠️使用注意事项
本规则尽可能多地拦截了趣智校园的流量，可能存在误杀，欢迎指正。如果无法登录，可以**先登录**，然后**清除缓存**，以后只要流量被接管，就不会再有广告了。  
如果提示检测到代理，请在clash设置中关闭设置系统代理，因为软件会检测系统代理状态，代理仍然生效。在移动数据网络下不会有这种情况，因为只有wifi才会暴露代理状态。

---

## 🖼️ 运行效果

| 拦截前 | 拦截后 |
| --- | --- |
| ![demo](./images/demo1-1.jpg) | ![demo](./images/demo1-2.jpg) |
| ![demo](./images/demo2-1.jpg) | ![demo](./images/demo2-2.jpg) |
| ![demo](./images/demo3-1.jpg) | ![demo](./images/demo3-2.jpg) |
| ![demo](./images/demo4-1.jpg) | ![demo](./images/demo4-2.jpg) |

---

## 🤝 贡献与反馈

如果你在安装或使用过程中发现有漏网之鱼（新的广告域名），欢迎提交 **Issue** 或 **Pull Request**。

## ⚖️ 免责声明

本项目仅提供去广告规则，不能直接去广告。仅供学习交流使用，请勿用于商业用途和实际部署。实际部署广告拦截为用户个人行为，后果由用户承担，作者不承担任何责任。

# 🤗太棒了

好耶，我终于做出了第一个原创且实用的项目,快给我小星星吧~