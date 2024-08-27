updateVisitCount();
function updateVisitCount() {
    fetch('https://8g52l2zz2m.execute-api.us-east-1.amazonaws.com/PROD/')
        .then(res => res.json())
        .then(data => {
            console.log(data)
            document.getElementById('count').innerHTML = data;
        })
    }
