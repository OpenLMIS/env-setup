delete from facility_type;
INSERT INTO facility_type (code, name, description, level_id, nominal_max_month, nominal_eop, display_order, is_active)
VALUES
('warehouse','Warehouse', 'Central Supply Depot',null,3,0.5, 11, TRUE),
('lvl3_hospital','Lvl3 Hospital', 'State Hospital',null,3,0.5,1, TRUE),
('lvl2_hospital','Lvl2 Hospital', 'Regional Hospital',null,3,0.5,2, TRUE),
('state_office','State Office', 'Management Office, no patient services',null,3,0.5,9, TRUE),
('district_office','District Office', 'Management Office, no patient services',null,3,0.5,10, TRUE),
('health_center','Health Center', 'Multi-program clinic',null,3,0.5,4, TRUE),
('health_post','Health Post', 'Community Clinic',null,3,0.5,5, TRUE),
('lvl1_hospital','Lvl1 Hospital', 'District Hospital',null,3,0.5,3, TRUE),
('satellite_facility','Satellite Facility', 'Temporary service delivery point',null,1,0.25,6, FALSE),
('chw','CHW', 'Mobile worker based out of health center',null,1,0.25,7, TRUE),
('dhmt','DHMT', 'District Health Management Team',null,3,0.5,8, TRUE);
