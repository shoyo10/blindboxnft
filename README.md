## Week 7 - HW2

做一個隨機自由 mint token 的 ERC721

* totalSupply: 500
* mint(): 基本正常 mint，不要達到上限 500 即可
* randomMint() 加分項目，隨機 mint tokenId (不重複)
  * 隨機的方式有以下選擇方式
    * 自己製作隨機 random，不限任何方法
    * Chainlink VRF
    * RANDAO
* Implement 盲盒機制
* 請寫測試確認解盲前的 tokenURI 及解盲後的 tokenURI


## Usage

Available in forge 0.2.0 (87283bc 2023-10-06T00:32:37.923803000Z)

### Install

```shell
$ forge install
```

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```