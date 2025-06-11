    - name: Checkout Code
      uses: actions/checkout@v4

    - name: Create .env.production file from secret
      run: echo "${{ secrets.ENV_PRODUCTION }}" > .env.production

    - name: Set up Node.js
      uses: actions/setup-node@v4
      with:
        node-version: 16

    - name: Install dependencies
      run: npm install

    - name: Build Docker Image
      run: |
        docker build \
          --build-arg TMDB_V3_API_KEY=${{ env.TMDB_API_KEY }} \
          -t netflix .
