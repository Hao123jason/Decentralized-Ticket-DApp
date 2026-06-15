# 去中心化二手票券交易與驗證系統 (Decentralized Ticket DApp)

本專案為大四區塊鏈課程之期末專題成果。系統結合了 Ethereum 智慧合約後端與網頁前端技術，建構出一個去中心化、不可竄改且具備公正信任機制的二手票券交易與真偽驗證平台。

---

## 🛠️ 技術棧 (Tech Stack)

- **智慧合約後端：** Solidity (v0.8.18)
- **合約開發與部署環境：** Remix IDE / EVM Version: Paris
- **本地測試區塊鏈節點：** Ganache (圖形化介面)
- **加密錢包互動層：** MetaMask Chrome Extension
- **網頁前端：** HTML5 / CSS3 / Vanilla JavaScript
- **區塊鏈通訊套件：** Web3.js (v1.5.2 via CDN)
- **本地伺服器託管：** VS Code Live Server Extension

---

## 🌟 核心功能

1. **Web3 錢包安全連線：** 前端自動偵測並異步連接 MetaMask 錢包，即時獲取用戶帳戶地址與本地鏈上餘額。
2. **主辦方活動建立：** 主辦方可自訂活動名稱、設定原價（ETH）及發行總張數，資料直接寫入區塊鏈 Mapping 結構中。
3. **安全一手購票：** 消費者透過網頁發起交易，支付對應 ETH 直接向合約購買。合約具備安全防錯機制（`require` 驗證餘額與是否售罄），確保資金安全移轉至主辦方。
4. **交易透明化追蹤：** 每一筆合約部署、活動建立、購票扣款皆會產生唯一的交易雜湊 (Transaction Hash)，並永久記錄於本地區塊鏈中。

---

## 🚀 專案編譯與執行說明 (Deployment & Running Guide)

請依序按照以下步驟建置環境並執行專案：

### 第一步：啟動本地區塊鏈節點 (Ganache)
1. 開啟 **Ganache** 軟體，選擇 "Quickstart" 啟動一個全新的本地測試區塊鏈。
2. 在帳戶列表中，點擊第一個帳戶最右側的「鑰匙」圖示，**複製該帳戶的私鑰 (Private Key)**。

### 第二步：設定 MetaMask 加密錢包
1. 點開 Chrome 的 **MetaMask** 擴充功能。
2. 切換網路至你的本地 Ganache 網路（通常為 `Localhost 8545` 或 `HTTP://127.0.0.1:7545`，鏈 ID 通常為 `1337`）。
3. 點擊頭像 -> **「匯入帳戶」 (Import Account)**，將剛剛複製的 Ganache 私鑰貼上，確認帳戶成功獲取 100 ETH 測試幣。

### 第三步：編譯與部署智能合約 (Remix)
1. 打開 [Remix IDE](https://remix.ethereum.org/)。
2. 建立新檔案 `TicketSystem.sol`，並貼上智能合約原始碼。
3. 切換至 **Solidity Compiler** 頁面：
   - Compiler 版本請選擇 **`0.8.18`**。
   - 展開 **Advanced Configurations**，將 **EVM Version** 修改為 **`paris`**。
   - 點擊 **Compile TicketSystem.sol**。
4. 切換至 **Deploy & Run Transactions** 頁面：
   - Environment 請選擇 **`Injected Provider - MetaMask`**（確保關聯到有 100 ETH 的帳戶）。
   - 點擊藍色的 **Deploy** 按鈕，並在跳出的 MetaMask 視窗點擊「確認」。
5. 部署成功後，在左下角 `Deployed Contracts` 區塊：
   - 複製新生成的 **合約地址 (Contract Address)**。
   - 在編譯頁面最下方點擊 **ABI** 按鈕，複製智慧合約的翻譯字典。

### 第四步：建置前端網頁並啟動
1. 在電腦中建立名為 `DApp_Project` 的資料夾，並在其中建立 **`index.html`** 檔案。
2. 將前端原始碼貼入 `index.html` 中，並修改以下變數：
   - 將 `const contractAddress = "你的新合約地址";` 替換為剛剛複製的地址。
   - 將 `const contractABI = [ ... ];` 替換為剛剛複製的完整 ABI 陣列。
3. 使用 **Visual Studio Code (VS Code)** 開啟整個 `DApp_Project` 資料夾（**【重要】請務必開啟整個資料夾，勿單獨開啟單一檔案**）。
4. 安裝 **Live Server** 擴充功能。
5. 在 `index.html` 程式碼畫面上按滑鼠右鍵，選擇 **「Open with Live Server」**（或點擊右下角藍色狀態列的 **Go Live**）。
6. 瀏覽器將自動彈出 `http://127.0.0.1:5500/index.html` 網頁。

### 第五步：系統完整功能測試
1. 在網頁上點擊 **「連接 MetaMask」**，確認正確抓取到你的錢包地址。
2. 點擊 **「建立活動」**，在跳出的 MetaMask 視窗確認支付微量 Gas 費。等待彈出「活動已建立」提示。
3. 點擊 **「購買一手票」**，在跳出的 MetaMask 視窗確認支付 1 ETH 與 Gas 費。等待彈出「購票完成」提示。
4. 打開 Ganache 軟體，點擊 **TRANSACTIONS** 標籤，即可查看完整的區塊鏈交易紀錄。

---

## 🛠️ 開發遇到困難與解決方案 (Troubleshooting)

1. **直接點擊 HTML 檔案導致 MetaMask 無法連線：**
   - *原因：* MetaMask 基於安全機制，拒絕非 HTTP 協定的本機檔案連線 (`file:///`)。
   - *解法：* 必須透過 VS Code 的 Live Server 啟動本地虛擬伺服器 (`http://127.0.0.1:5500`) 進行安全存取。
2. **Ganache 重啟後網頁交易卡住 (already pending)：**
   - *原因：* 測試鏈重置後狀態與 MetaMask 本地交易歷史序號 (Nonce) 產生記憶衝突。
   - *解法：* 點進 MetaMask 的「設定」->「進階」，點擊**「清除活動資料夾資料」 (Clear activity tab data)** 清空快取以重新對齊。
3. **EVM 版本不相容導致合約部署退件：**
   - *原因：* 最新版 Remix 的編譯參數產生的 Bytecode 太過前沿，Ganache 的虛擬機無法解析。
   - *解法：* 將編譯器版本降級至 `0.8.18` 並將 EVM 版本強制指定為 `paris` 後重新發布。
