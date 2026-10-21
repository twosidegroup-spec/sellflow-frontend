$body = @'
{
  "email": "test@test.com",
  "full_name": "Test User",
  "phone": "",
  "business_name": "Test Business",
  "password": "1234"
}
'@

$response = Invoke-WebRequest -Uri "https://sellflow-backend-0nyn.onrender.com/api/v1/auth/register" -Method Post -ContentType "application/json" -Body $body

Write-Host "Status: $($response.StatusCode)"
Write-Host "Response:"
Write-Host $response.Content
