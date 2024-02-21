# NTUST Asset Management Plugin for Redmine

http://localhost:3000/assets 進入資產列表頁面

## 安裝
```bash
cd /path/to/redmine
cd plugins
git clone https://github.com/zyx1121/ntust.asset.manager ntust_asset_manager
```

## 新增資產
進入 rails 控制台
```bash
rails console
```
新增資產
```ruby
Asset.create(name: "Laptop", description: "A very nice laptop.", status: "Available")
```