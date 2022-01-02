var entrants = {};
var index = 0;

var xmlhttp = new XMLHttpRequest();
xmlhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
        entrants = JSON.parse(this.responseText);
    }
};
xmlhttp.open("GET", "entrants.json", true);
xmlhttp.send();

function cycle() {
    document.getElementById('profile').src = entrants[index].profile;
    document.getElementById('name').innerHTML = entrants[index].name;
    document.getElementById('handle').innerHTML = "<span>@</span>" + entrants[index].handle;

    if (entrants[index + 1] == undefined) {
        index = 0;
    } else {
        index++;
    }
}

var id;
function start() {
    id = setInterval(cycle, 75);
    document.getElementById('button').setAttribute("onclick", "stop()");
    document.getElementById('button').innerHTML = "Stop";
}
function stop() {
    clearInterval(id);
    document.getElementById('button').setAttribute("onclick", "start()");
    document.getElementById('button').innerHTML = "Start";
}
