# NTUST Asset Management Plugin for Redmine

新增資產管理功能，查閱目前各個資產借還狀態，進行資產借出與歸還。

## Routes

### 查詢資產列表

```json
GET /api/assets

[
  {
    "id": 1,
    "name": "資產名稱",
    "status": "Available"
  },
  {
    "id": 2,
    "name": "資產名稱",
    "status": "CheckedOut"
  },
  ...
]
```

### 新增資產

```json
POST /api/assets

{
  "name": "資產名稱"
}
```

### 查詢資產

```json
GET /api/assets/:id

{
  "id": 1,
  "name": "資產名稱",
  "status": "Available"
}
```

### 修改資產

```json
PUT /api/assets/:id

{
  "name": "資產名稱",
  "status": "CheckedOut"
}
```
