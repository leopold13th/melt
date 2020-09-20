var app = new Vue({ 
    el: '#app',
    data: {
        actives: [
            { text: 'Apple', ticker: 'AAPL', qty: 2, price: 109.05, pricenow: 105.17 },
            { text: 'Microsoft', ticker: 'MSFT', qty: 2, price: 205.75, pricenow: 201.88 }
        ]
    }
});