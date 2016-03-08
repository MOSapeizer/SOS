$(function(){

	d3.select("#graph")
		.append("svg");


	d3.csv("data.csv", type, function(error, data){
		pie_chart(data);
	});

	var pie_chart = function(data){
		console.log(data);
	};

	var type = function(d){
		d.population = +d.population
		return d;
	};
});