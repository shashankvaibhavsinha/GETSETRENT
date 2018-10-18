function openNav() {
    document.getElementById("mySidenav").style.width = "250px";
    //document.getElementById("main").style.marginLeft = "250px";
    document.getElementById("logoname").style.marginLeft = "250px";
}

function closeNav() {
    document.getElementById("mySidenav").style.width = "0";
    //document.getElementById("main").style.marginLeft= "0";
    document.getElementById("logoname").style.marginLeft= "0";
}
function rrr(){
	if(document.getElementById('rrr_down').style.display == "inline"){
		document.getElementById('rrr').style.display = "block";
		document.getElementById('rrr_up').style.display = "inline";
		document.getElementById('rrr_down').style.display = "none";
	}
	else{
		document.getElementById('rrr').style.display = "none";
		document.getElementById('rrr_down').style.display = "inline";
		document.getElementById('rrr_up').style.display = "none";
	}
}
function rrs(){
	if(document.getElementById('rrs_down').style.display == "inline"){
		document.getElementById('rrs').style.display = "block";
		document.getElementById('rrs_up').style.display = "inline";
		document.getElementById('rrs_down').style.display = "none";
	}
	else{
		document.getElementById('rrs').style.display = "none";
		document.getElementById('rrs_down').style.display = "inline";
		document.getElementById('rrs_up').style.display = "none";
	}
}
function ars(){
	if(document.getElementById('ars_down').style.display == "inline"){
		document.getElementById('ars').style.display = "block";
		document.getElementById('ars_up').style.display = "inline";
		document.getElementById('ars_down').style.display = "none";
	}
	else{
		document.getElementById('ars').style.display = "none";
		document.getElementById('ars_down').style.display = "inline";
		document.getElementById('ars_up').style.display = "none";
	}
}
function dashboard(){
	document.getElementById('search_house').style.display = "none";
	document.getElementById('add_house').style.display = "none";
	document.getElementById('view_house').style.display = "none";
	document.getElementById('edit_profile').style.display = "none";
	document.getElementById('dashboard').style.display = "block";
}
function edit_profile(){
	document.getElementById('search_house').style.display = "none";
	document.getElementById('add_house').style.display = "none";
	document.getElementById('view_house').style.display = "none";
	document.getElementById('dashboard').style.display = "none";
	document.getElementById('edit_profile').style.display = "block";
}
function search_house(){
	document.getElementById('dashboard').style.display = "none";
	document.getElementById('add_house').style.display = "none";
	document.getElementById('view_house').style.display = "none";
	document.getElementById('edit_profile').style.display = "none";
	document.getElementById('search_house').style.display = "block";
}
function add_house(){
	document.getElementById('dashboard').style.display = "none";
	document.getElementById('search_house').style.display = "none";
	document.getElementById('view_house').style.display = "none";
	document.getElementById('edit_profile').style.display = "none";
	document.getElementById('add_house').style.display = "block";
	document.getElementById('position').style.display = "block";
	document.getElementById('house_det').style.display = "none";
}
function view_house(){
	document.getElementById('dashboard').style.display = "none";
	document.getElementById('search_house').style.display = "none";
	document.getElementById('add_house').style.display = "none";
	document.getElementById('edit_profile').style.display = "none";
	document.getElementById('view_house').style.display = "block";
}
function add_details()
	{
		document.getElementById('position').style.display = "none";
		document.getElementById('house_det').style.display = "block";
		
	}
    function setRegions()
    {
    	for (region in countries)
    		document.write('<option value="' + region + '">' + region + '</option>');
    	var map = new google.maps.Map(document.getElementById('map'), {
            mapTypeID:google.maps.MapTypeId.ROADMAP,
            zoom: 2,
          });
    	myMap(region, map);
    }

    function set_country(oRegionSel, oCountrySel, oCity_StateSel)
    {
    	var countryArr;
    	oCountrySel.length = 0;
    	oCity_StateSel.length = 0;
    	var region = oRegionSel.options[oRegionSel.selectedIndex].text;
    	if (countries[region])
    	{
    		oCountrySel.disabled = false;
    		oCity_StateSel.disabled = true;
    		oCountrySel.options[0] = new Option('SELECT COUNTRY','');
    		countryArr = countries[region].split('|');
    		for (var i = 0; i < countryArr.length; i++)
    			oCountrySel.options[i + 1] = new Option(countryArr[i], countryArr[i]);
    		document.getElementById('txtregion').innerHTML = region;
    		var map = new google.maps.Map(document.getElementById('map'), {
                mapTypeID:google.maps.MapTypeId.ROADMAP,
                zoom: 2,
              });
        	myMap(region, map);
    		//document.getElementById('txtplacename').innerHTML = '';
    	}
    	else oCountrySel.disabled = true;
    }

    function set_city_state(oCountrySel, oCity_StateSel)
    {
    	var city_stateArr;
    	oCity_StateSel.length = 0;
    	var country = oCountrySel.options[oCountrySel.selectedIndex].text;
    	if (city_states[country])
    	{
    		oCity_StateSel.disabled = false;
    		oCity_StateSel.options[0] = new Option('SELECT NEAREST DIVISION','');
    		city_stateArr = city_states[country].split('|');
    		for (var i = 0; i < city_stateArr.length; i++)
    			oCity_StateSel.options[i+1] = new Option(city_stateArr[i],city_stateArr[i]);
    		document.getElementById('txtplacename').innerHTML = country;
    		var map = new google.maps.Map(document.getElementById('map'), {
                mapTypeID:google.maps.MapTypeId.ROADMAP,
                zoom: 4,
              });
    		myMap(country, map);
    	}
    	else oCity_StateSel.disabled = true;
    }

    function print_city_state(oCountrySel, oCity_StateSel)
    {
    	var country = oCountrySel.options[oCountrySel.selectedIndex].text;
    	var city_state = oCity_StateSel.options[oCity_StateSel.selectedIndex].text;
    	if (city_state && city_states[country].indexOf(city_state) != -1)
    	{
    		var cityloc = city_state + ', ' + country;
    		document.getElementById('txtplacename').innerHTML = cityloc;
    		var map = new google.maps.Map(document.getElementById('map'), {
                mapTypeID:google.maps.MapTypeId.ROADMAP,
                zoom: 7,
              });
    		myMap(cityloc, map);
    		document.getElementById('city').disabled = false;
    	}
    	else document.getElementById('txtplacename').innerHTML = country;
    	document.getElementById('addstate').value = city_state;
    }
    function city_val()
    {	
    	var citi = document.getElementById('city').value;
    	var city = citi + ", " + document.getElementById('txtplacename').innerHTML;
    	document.getElementById('txtplacename').innerHTML = city;
    	var map = new google.maps.Map(document.getElementById('map'), {
            mapTypeID:google.maps.MapTypeId.ROADMAP,
            zoom: 14,
          });
		myMap(city, map);
		document.getElementById('addcity').value = citi;
    }
    function initMap()
    {
    	var mapCanvas = document.getElementById("map");
    	var mapOptions = {
    	  center: new google.maps.LatLng(23.64216,86.169075), zoom: 2
    	};
    	var map = new google.maps.Map(mapCanvas, mapOptions);
    }
    function myMap(address, map){
	   
		    var geocoder = new google.maps.Geocoder();
    		geocodeAddress(geocoder, map);
    		var marker;
              
              function placeMarker(location) {
            	    if ( marker ) {
            	      marker.setPosition(location);
            	    } else {
            	      marker = new google.maps.Marker({
            	        position: location,
            	        map: map
            	      });
            	    }
            	  }
              
              google.maps.event.addListener(map, 'click', function(event) {
            	    placeMarker(event.latLng);
            	    //*****************
            	    var myLatLng = event.latLng;
            	    var lat = myLatLng.lat();
            	    var lng = myLatLng.lng();
            	    //********************
            	    var posn=marker.getPosition();
            	    alert(posn);
            	    document.getElementById("coordinate").innerHTML = "Your Coordinate " + posn;
            	    document.getElementById("lat").value = lat;
            	    document.getElementById("long").value = lng;
            	  });

          }

          function geocodeAddress(geocoder, resultsMap) {
        	  var address = document.getElementById('txtplacename').innerHTML;
        	geocoder.geocode({'address': address}, function(results, status) {
              if (status === 'OK') {
                resultsMap.setCenter(results[0].geometry.location);
              } else {
                alert('Unable to Locate: ' + status);
              }
            });
	  }