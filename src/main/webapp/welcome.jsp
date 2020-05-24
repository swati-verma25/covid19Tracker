<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="head.jsp"></jsp:include>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script> -->
</head>
<script type="text/css">
.test {
  style="padding-top: 16px;display: inline-block;"
}
</script>
<body id="page-top">
	<jsp:include page="nav.jsp"></jsp:include>
	<div class="container-fluid">
		<div class="row" id="card0div">
			<div class="col-3">
				<h6>
					<b>Total confirmed cases</b>
				</h6>
				<div
					style="font-size: 32px; color: #DE3700; font-weight: bold; line-height: 40px; padding-top: 16px;"
					id="total"></div>
				<div style="padding-top: 16px;">
					<h2 style="font-size: 13px;">
						<div style="background:yellow;height:10px;width:10px;border-radius:50px;display: inline-block;"></div>
						<div style="padding-top: 16px;display: inline-block;max-width: 200px;width: 186px;font-weight: bold;">Active Cases</div>
						<div style="padding-top: 16px;display: inline-block;max-width: 200px;width: 145px;text-align: right;" id="activeCases"></div>
					</h2>
					<h2 style="font-size: 13px;">
						<div style="background:green;height:10px;width:10px;border-radius:50px;display: inline-block;"></div>
						<div style="padding-top: 16px;display: inline-block;max-width: 200px;width: 186px;font-weight: bold;">Recovered Cases</div>
						<div style="padding-top: 16px;display: inline-block;max-width: 200px;width: 145px;text-align: right;" id="recoveredTotal"></div>
					</h2>
					<h2 style="font-size: 13px;">
						<div style="background:black;height:10px;width:10px;border-radius:50px;display: inline-block;"></div>
						<div style="padding-top: 16px;display: inline-block;max-width: 200px;width: 186px;font-weight: bold;">Fatal Cases</div>
						<div style="padding-top: 16px;display: inline-block;max-width: 200px;width: 145px;text-align: right;" id="fatalCases"></div>
					</h2>
					
				</div>
				<div style="padding-top: 16px;">
					<hr/>
					<div id="countryDiv" class="table-responsive">
					
					</div>
				</div>
			</div>
			<div class="col-4">
				<div class='accordion' id='myAccordion'>
					<div class='card'>
						<div class=' table-responsive' id='headingOne'>
							<h2 class='mb-0'>
								<table class="table table-striped"
									style="font-size: 15px;overflow-y: scroll; ">
									<!-- <thead class='thead-dark'> -->
										<tr>
											<th data-toggle='collapse' data-target='#collapseOne' style="height:29px; cursor: pointer;" class="fas fa-fw fa-minus-circle" onclick="changeIcon('head');" id="head"></th>
											<th style="width: 90%" >State</th>
											<th style="width: 10%">Confirmed</th>
										</tr>
									<!-- </thead> -->
								</table>
							</h2>
						</div>
						<div id='collapseOne' class='collapse show'
							aria-labelledby='headingOne' data-parent='#myAccordion'>
							<div id="country_report_data" style="overflow-y: scroll; height:350px;"></div>
						</div>
					</div>
				</div>
				<div style="height: 400px;">
					<canvas id="bar-chart-horizontal" width="800" height="350"></canvas>
				</div>
												
			</div>
			<div class="col-5">
				<div>
					<canvas id="line-chart" width="800" height="470"></canvas>
				</div>
				<div>
					<canvas id="pie-chart" width="800" height="450"></canvas>
				</div>
			</div>
			
			
		</div>
		
	</div>


	<jsp:include page="script.jsp"></jsp:include>
	<script>

	function test (labelValue) {

	    // Nine Zeroes for Billions
	    return Math.abs(Number(labelValue)) >= 1.0e+9

	    ? Math.abs(Number(labelValue)) / 1.0e+9 + "B"
	    // Six Zeroes for Millions 
	    : Math.abs(Number(labelValue)) >= 1.0e+6

	    ? Math.abs(Number(labelValue)) / 1.0e+6 + "M"
	    // Three Zeroes for Thousands
	    : Math.abs(Number(labelValue)) >= 1.0e+3

	    ? Math.abs(Number(labelValue)) / 1.0e+3 + "K"

	    : Math.abs(Number(labelValue));

	}


	function getRandomColor() {
		  var letters = '0123456789ABCDEF';
		  var color = '#';
		  for (var i = 0; i < 6; i++) {
		    color += letters[Math.floor(Math.random() * 16)];
		  }
		  return color;
		}
	
	
		 $.ajax({
					url : "https://pomber.github.io/covid19/timeseries.json",
					type : 'GET',
					dataType : 'json',
					success : function(res) {
						var map = res;
						var confirmed = 0;
						var death = 0;
						var recovered = 0;
						var dateArray=[];
						var nameArray=[];
						var colorArray=[];
						var datahorizontalArray=[];
						var colors = ['#ff0000', '#00ff00', '#0000ff'];
						var cityDataArray=[];
						var countryDiv="<table  class='table table-striped table-sm' id='countryTable'><thead><th>Country</th><th>Count</th></thead><tbody>";

						$.each(res, function(i, obj) {
							var len = map[i].length;
							//for(var j=0;j<len;j++){

							confirmed = confirmed
									+ intVal(map[i][len - 1].confirmed);
							death = death + intVal(map[i][len - 1].deaths);
							recovered = recovered
									+ intVal(map[i][len - 1].recovered);

							//}

							if(i=='Afghanistan'){
							for(var j=0;j<len;j++){
								dateArray.push(map[i][j].date);
							}
							//console.log(dateArray);
							}
							if((intVal(map[i][len-1].confirmed)>50000) || i=='India'){
								var cityData={};
								var dataArrayCity=[];
								for(var j=0;j<len;j++){
									dataArrayCity.push(map[i][j].confirmed+"");
								}
								cityData['data']=dataArrayCity;
								cityData['label']=i;
								cityData['borderColor']=getRandomColor();
								cityData['fill']=false;
								cityDataArray.push(cityData);

								nameArray.push(i);
								colorArray.push(getRandomColor());
								datahorizontalArray.push(confirmed);

							}
							//console.log(JSON.stringify(cityDataArray));
							countryDiv =countryDiv+"<tr><td>"+i+"</td><td>"+map[i][len - 1].confirmed+"</td></tr>"
						});

						 new Chart(document.getElementById("line-chart"), {
							  type: 'line',
							  data: {
							    labels: dateArray,
							    datasets: cityDataArray
							  },
							  options: {
							    title: {
							      display: true,
							      text: 'COVID19 Cummulative Confirmed Country-Date Wise'
							    }
							  }
							});


						 new Chart(document.getElementById("bar-chart-horizontal"), {
							    type: 'horizontalBar',
							    data: {
							      labels: nameArray,
							      datasets: [
							        {
							          label: "Population (millions)",
							          backgroundColor: colorArray,
							          data: datahorizontalArray
							        }
							      ]
							    },
							    options: {
							      legend: { display: false },
							      title: {
							        display: true,
							        text: 'COVID19 Country Wise'
							      }
							    }
							});


						 new Chart(document.getElementById("pie-chart"), {
							    type: 'pie',
							    data: {
							      labels:nameArray,
							      datasets: [{
							        label: "Population (millions)",
							        backgroundColor: colorArray,
							        data: datahorizontalArray
							      }]
							    },
							    options: {
							      title: {
							        display: true,
							        text: 'COVID19  Pie Chart'
							      }
							    }
							});

						 var ctx = document.getElementById("line-chart");
						 ctx.style.height = "420px";
						 
						 var ctx = document.getElementById("bar-chart-horizontal");
						 ctx.style.height = "350px";
							
						countryDiv =countryDiv+"</tbody></table>";
						$("#total").append(confirmed.toLocaleString());
						$("#activeCases").append((confirmed-recovered-death).toLocaleString());
						$("#recoveredTotal").append(recovered.toLocaleString());
						$("#fatalCases").append(death.toLocaleString());
						$("#countryDiv").append(countryDiv);

						var table =  $("#countryTable").DataTable();
					}
				}); 

		var intVal = function(i) {
			return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1
					: typeof i === 'number' ? i : 0;
		};


		/* $.ajax({
			url : "https://api.covid19india.org/state_district_wise.json",
			type : 'GET',
			dataType : 'json',
			success : function(res) {
				var map = res;
				var countryWiseDiv="<table  class='table table-striped table-sm' id='countryWiseTable'><thead><th>State</th><th>Confirmed</th></thead><tbody>";
				var total = "";
				$.each(res, function(idx, obj1) {
					var state= idx;
					var totalState = 0;
					$.each(map[idx]["districtData"], function(i, obj2) {
						totalState=totalState+obj2.confirmed;
						
					});
					countryWiseDiv =countryWiseDiv+"<tr><td>"+state+"</td><td>"+totalState+"</td></tr>";
				});		

				$("#countryWiseDiv").append(countryWiseDiv);
				var table =  $("#countryWiseTable").DataTable();		
			}
		}); */

		$.ajax({
			url : "https://api.covid19india.org/state_district_wise.json",
			type : 'GET',
			dataType : 'json',
			success : function(res) {
				
				var map = res;
				var countryWiseDiv="<table  class='table table-striped table-sm' id='countryWiseTable'><thead><th>State</th><th>Confirmed</th></thead><tbody>";
				var total = "";
				var index=0;
				$.each(res, function(idx, obj1) {
					var state= idx;
					var dmsData = "";
					var totalState = 0;
					$.each(map[idx]["districtData"], function(i, obj2) {
						totalState=totalState+obj2.confirmed;
						
					});
					
					dmsData = dmsData+ " <div class='' id='headingOne"+index+"'>";
					dmsData = dmsData+ " <h2 class='mb-0'><table class='table table-striped' style='font-size: 15px;' id='table_"+index+"'><tr>";
					dmsData = dmsData+ " <th data-toggle='collapse' data-target='#collapseOne"+ index+ "' style='cursor: pointer;height:42px;' class='fas fa-fw fa-plus-circle' onclick='changeIcon("+index+");' id='"+index+"'></th>";
					
					dmsData = dmsData+ " <th data-toggle='collapse' data-target='#collapseOne"+ index+ "' style='cursor: pointer;width: 90%'>"+ state + "</th>";
					dmsData = dmsData+ " <th style='width: 10%'>"+ totalState + "</th>";
					dmsData = dmsData+ " </tr></table> </h2>";
					dmsData = dmsData + "  </div>";
					dmsData = dmsData+ "  <div id='collapseOne"+index+"' class='collapse' aria-labelledby='headingOne"+index+"' >";
					dmsData = dmsData+ "  <div class='card-body'>";
					dmsData = dmsData+ displayData(obj1["districtData"]);
					dmsData = dmsData + "  </div>";
					dmsData = dmsData + " </div>";

					$("#country_report_data").append(dmsData);
					index++;
				});		

				
				//var table =  $("#countryWiseTable").DataTable();		
			}
		});

		function displayData(obj){
			dmsData = " <div>";
			dmsData = dmsData+ " <h2 class='mb-0'><table class='table table-bordered' style='font-size: 15px;'>";
			$.each(obj, function(i, obj2) {
				
				dmsData = dmsData+ "<tr style='font-weight: bold;color: black;background-color: lightblue;' ><th style='width: 90%'>"+ i + "</th>";
				dmsData = dmsData+ " <th style='width: 10%'>"+ obj[i].confirmed + "</th></tr>";
			
			});
			dmsData = dmsData+ " </table> </h2>";
			dmsData = dmsData + "  </div>";
			return dmsData;
			
		}

		function changeIcon(id){
			if($('#'+id).hasClass('fa-plus-circle')){
				 $('#'+id).removeClass("fa-plus-circle");
					$('#'+id).addClass("fa-minus-circle");
			}else{
			 $('#'+id).removeClass("fa-minus-circle");
				$('#'+id).addClass("fa-plus-circle");
			}
	}
	</script>

</body>

</html>
