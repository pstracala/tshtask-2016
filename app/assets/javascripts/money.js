//= require Chart



jQuery(function() {
    function cos(price, labels) {
        return price.slice(1, labels.length-1).split(', ').map(function (x) {
            return parseFloat(x);
        });
    }
    if (document.getElementById("chart")) {
        var data, myNewChart;
        var labels = document.getElementById("chart").getAttribute("labels");
        var sell_price_array = document.getElementById("chart").getAttribute("sell_price_array");
        var buy_price_array = document.getElementById("chart").getAttribute("buy_price_array");
        
        data = {
            labels: labels.slice(1, labels.length-1).split(','),
            datasets: [
                {
                    label: "Buy price",
                    fillColor: "rgba(220,220,220,0.2)",
                    strokeColor: "rgba(220,220,220,1)",
                    pointColor: "rgba(220,220,220,1)",
                    pointStrokeColor: "#fff",
                    pointHighlightFill: "#fff",
                    pointHighlightStroke: "rgba(220,220,220,1)",
                    data: cos(buy_price_array, labels)
                },
                {
                    label: "Sell price",
                    fillColor: "rgba(151,187,205,0.2)",
                    strokeColor: "rgba(151,187,205,1)",
                    pointColor: "rgba(151,187,205,1)",
                    pointStrokeColor: "#fff",
                    pointHighlightFill: "#fff",
                    pointHighlightStroke: "rgba(151,187,205,1)",
                    data: cos(sell_price_array, labels)
                }
            ]
        };
        return myNewChart = new Chart($("#chart").get(0).getContext("2d")).Line(data);
    }
});
