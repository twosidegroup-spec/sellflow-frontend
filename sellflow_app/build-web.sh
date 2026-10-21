#!/bin/bash
# Build Flutter Web for TSG Local

flutter build web --release --dart-define=TSG_API_URL=http://localhost:8000/api/v1
echo "✅ Build complete!"
echo "   Now re-deploy docker: docker-compose up -d"
