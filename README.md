# Nexus Reinsurance

***
## 【Introduction of Nexus Reinsurance】
- This is a smart contract for creating a reinsurance layer for Nexus, where users can stake Uniswap/Balancer LP tokens in return for additional wNXM rewards. In return, if Nexus’ MCR% drops below a certain threshold (eg 80%) then Nexus can claim a portion of the LP tokens, withdraw their underlying assets and transfer the assets into the Nexus Mutual pool.


&nbsp;

***

## 【Workflow】
- Workflow of Nexus Reinsurance
  - Reinsurance capital is provided by Uniswap/Balancer LP’s in high quality assets only (eg ETH,DAI,USDC etc)
  - Capital is rewarded with wNXM tokens which are paid for by Nexus Mutual.
  - Claim triggers are defined if MCR% drops below a certain threshold then a certain amount of LP tokens are taken and injected into Nexus Mutual as capital.
  - Reinsurance Pool Factory is a generalised protocol that deploys pools for Nexus as well as other projects.
  - Nexus Reinsurance Pool Manager interfaces between Nexus Mutual and the Reinsurance Pool/s and manages settings and interactions between different reinsurance pools
![Screen Shot 2020-12-01 at 16 52 04](https://user-images.githubusercontent.com/19357502/100712128-9c774b80-33f5-11eb-83ce-1fb665bccc4a.png)
(Source from: https://docs.google.com/document/d/1EZLRdxkfb-3lbkAp1FNrIs4vkDXPfNko6PJ0IMnp4vw/edit# )

&nbsp;

***

## 【Setup】
### ① Install modules
```
$ npm install
```

<br>

### ② Compile & migrate contracts (on Kovan testnet)
```
$ npm run migrate:kovan
```

<br>

### ③ Execute script (it's instead of testing)
```
$ npm run script:kovan
```


&nbsp;

***

## 【References】
- Nexus Mutual
  - Nexus Reinsurance Layer in Gitcoin  
    https://gitcoin.co/issue/NexusMutual/smart-contracts/48/100024186

  - MCR% stands for Minimum Capital Requirement %  
    https://nexusmutual.gitbook.io/docs/docs#capital-model

  - Nexus Reinsurance Layer  
    https://docs.google.com/document/d/1EZLRdxkfb-3lbkAp1FNrIs4vkDXPfNko6PJ0IMnp4vw/edit
