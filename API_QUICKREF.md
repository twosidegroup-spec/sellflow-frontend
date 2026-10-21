# SellFlow API Quick Reference

## For Flutter Developer

**Base URL:** `http://localhost:8000/api/v1`

---

## Authentication

### Register
```dart
POST /auth/register
{
  "email": "user@example.com",
  "password": "secure123",
  "full_name": "John Doe",
  "phone": "+1234567890",
  "business_name": "My Shop"
}
// Returns: {id, email, full_name, business_id, business_name}
```

### Login
```dart
POST /auth/login
{
  "email": "user@example.com",
  "password": "secure123"
}
// Returns: {access_token, token_type: "bearer"}
```

### Current User (Protected)
```dart
GET /auth/me
Headers: Authorization: Bearer <token>
// Returns: {id, email, full_name, phone}
```

---

## Products

```dart
GET /businesses/{business_id}/products
// List all products

POST /businesses/{business_id}/products
{
  "name": "Product Name",
  "sku": "SKU123",
  "stock": 100,
  "unit_price": 99.99,
  "cost_price": 50.00
}

PUT /businesses/{business_id}/products/{id}
// Update product

DELETE /businesses/{business_id}/products/{id}
// Delete product
```

---

## Orders

```dart
GET /businesses/{business_id}/orders
// List orders

POST /businesses/{business_id}/orders
{
  "customer_id": 1,
  "items": [
    {"product_id": 1, "quantity": 3, "unit_price": 99.99, "cost_price": 50.00}
  ]
}
// Returns order with calculated totals

PATCH /businesses/{business_id}/orders/{id}/status
{
  "status": "confirmed"
}
```

**Order Statuses:** `pending`, `confirmed`, `processing`, `shipped`, `delivered`, `cancelled`

---

## Payments

```dart
POST /businesses/{business_id}/payments
{
  "order_id": 1,
  "amount": 299.97,
  "method": "bkash",
  "transaction_ref": "TXN123456"
}
```

**Methods:** `bkash`, `nagad`, `rocket`, `upay`, `cash`

---

## Analytics

```dart
GET /businesses/{business_id}/analytics/summary
// Returns: {total_revenue, total_orders, total_customers, total_products, total_profit}
```

---

## Headers

All requests:
```
Content-Type: application/json
Authorization: Bearer <access_token>
```

---

## Error Responses

```json
{"detail": "Error message"}
```

| Status | Meaning |
|--------|---------|
| 200 | Success |
| 201 | Created |
| 400 | Validation error |
| 401 | Invalid/missing token |
| 404 | Not found |
| 429 | Rate limited |

---

## Swagger Docs

Visit: `http://localhost:8000/docs`
