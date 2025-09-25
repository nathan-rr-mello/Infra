SELECT
  'create table ' || table_name || ' as select * from arruda.' || table_name || ';'
FROM
  all_tables
WHERE
    owner = 'ARRUDA'
    AND table_name LIKE 'AIR_%';
    
create table AIR_AIRLINES as select * from arruda.AIR_AIRLINES;
create table AIR_AIRPLANES as select * from arruda.AIR_AIRPLANES;
create table AIR_AIRPLANE_TYPES as select * from arruda.AIR_AIRPLANE_TYPES;
create table AIR_AIRPORTS as select * from arruda.AIR_AIRPORTS;
create table AIR_AIRPORTS_GEO as select * from arruda.AIR_AIRPORTS_GEO;
create table AIR_BOOKINGS as select * from arruda.AIR_BOOKINGS;
create table AIR_FLIGHTS as select * from arruda.AIR_FLIGHTS;
create table AIR_FLIGHTS_SCHEDULES as select * from arruda.AIR_FLIGHTS_SCHEDULES;
create table AIR_PASSENGERS as select * from arruda.AIR_PASSENGERS;
create table AIR_PASSENGERS_DETAILS as select * from arruda.AIR_PASSENGERS_DETAILS;

-- 1.
select p.FIRSTNAME || ' ' || p.LASTNAME AS NAME, 
pd.city, 
TRUNC(MONTHS_BETWEEN(SYSDATE, pd.birthdate) / 12) AS AGE
from AIR_PASSENGERS p
join AIR_PASSENGERS_DETAILS pd
on p.passenger_id = pd.passenger_id
where pd.sex = 'w'
and pd.birthdate <= ADD_MONTHS(SYSDATE, -40 * 12)
and pd.country = 'BRAZIL'
;

-- 2
select airlines.airline_name,
airplanes.airplane_id,
airplane_type.name,
f.flightno
from AIR_FLIGHTS f
join AIR_AIRLINES airlines on f.airline_id = airlines.airline_id
join AIR_AIRPLANES airplanes on f.airplane_id = airplanes.airplane_id
join AIR_AIRPLANE_TYPES airplane_type on airplanes.airplane_type_id = airplane_type.airplane_type_id
join AIR_AIRPORTS_GEO a_from on f.from_airport_id = a_from.airport_id
join AIR_AIRPORTS_GEO a_to on f.to_airport_id = a_to.airport_id
where a_from.country = 'BRAZIL'
and a_to.country = 'BRAZIL'
;

-- 3 (mudar data)
select f.flightno,
airports_from.name,
airports_to.name,
passengers.FIRSTNAME || ' ' || passengers.LASTNAME as passenger_name,
bookings.seat
from air_flights f
join air_airports airports_from on f.from_airport_id = airports_from.airport_id
join air_airports airports_to on f.to_airport_id = airports_to.airport_id
join air_bookings bookings on f.flight_id = bookings.flight_id
join air_passengers passengers on bookings.passenger_id = passengers.passenger_id
where f.departure between trunc(to_date('2023-03-25', 'YYYY-MM-DD')) and trunc(to_date('2023-03-25', 'YYYY-MM-DD')+1)-(1/(24*60*60));

-- 4 (mudar datas)
select al.airline_name,
f.departure,
ag.city
from air_flights f
join air_airlines al on al.airline_id = f.airline_id
join air_airports_geo ag on ag.airport_id = f.to_airport_id
where ag.city = 'NEW YORK'
and (f.departure
between trunc(to_date('2023-03-01', 'YYYY-MM-DD')) and trunc(to_date('2023-03-01', 'YYYY-MM-DD')+1)-(1/(24*60*60))
or f.departure between trunc(to_date('2023-03-02', 'YYYY-MM-DD')) and trunc(to_date('2023-03-02', 'YYYY-MM-DD')+1)-(1/(24*60*60))
or f.departure between trunc(to_date('2023-03-07', 'YYYY-MM-DD')) and trunc(to_date('2023-03-07', 'YYYY-MM-DD')+1)-(1/(24*60*60))
or f.departure between trunc(to_date('2023-03-08', 'YYYY-MM-DD')) and trunc(to_date('2023-03-08', 'YYYY-MM-DD')+1)-(1/(24*60*60))
or f.departure between trunc(to_date('2023-03-09', 'YYYY-MM-DD')) and trunc(to_date('2023-03-09', 'YYYY-MM-DD')+1)-(1/(24*60*60))
or f.departure between trunc(to_date('2023-03-14', 'YYYY-MM-DD')) and trunc(to_date('2023-03-14', 'YYYY-MM-DD')+1)-(1/(24*60*60))
or f.departure between trunc(to_date('2023-03-15', 'YYYY-MM-DD')) and trunc(to_date('2023-03-15', 'YYYY-MM-DD')+1)-(1/(24*60*60))
or f.departure between trunc(to_date('2023-03-16', 'YYYY-MM-DD')) and trunc(to_date('2023-03-16', 'YYYY-MM-DD')+1)-(1/(24*60*60))
or f.departure between trunc(to_date('2023-03-21', 'YYYY-MM-DD')) and trunc(to_date('2023-03-21', 'YYYY-MM-DD')+1)-(1/(24*60*60))
or f.departure between trunc(to_date('2023-03-22', 'YYYY-MM-DD')) and trunc(to_date('2023-03-22', 'YYYY-MM-DD')+1)-(1/(24*60*60))
or f.departure between trunc(to_date('2023-03-23', 'YYYY-MM-DD')) and trunc(to_date('2023-03-23', 'YYYY-MM-DD')+1)-(1/(24*60*60))
or f.departure between trunc(to_date('2023-03-28', 'YYYY-MM-DD')) and trunc(to_date('2023-03-28', 'YYYY-MM-DD')+1)-(1/(24*60*60))
or f.departure between trunc(to_date('2023-03-29', 'YYYY-MM-DD')) and trunc(to_date('2023-03-29', 'YYYY-MM-DD')+1)-(1/(24*60*60))
or f.departure between trunc(to_date('2023-03-30', 'YYYY-MM-DD')) and trunc(to_date('2023-03-30', 'YYYY-MM-DD')+1)-(1/(24*60*60)))
;



