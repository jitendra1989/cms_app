# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
	
	# 1= admin
	# 2= principal
	# 3= cloudadmin


		if MgUser.count == 0
		  puts "Creating admin user"
		  user = MgUser.create([
		  	
		  	{
		  		id: 1,user_name: 'cloudadmin', first_name: 'cloudadmin',middle_name: 'singh',last_name: 'singh',email: 'ssingh@mindcomgroup.com',password:'admin',user_type:'cloudadmin',is_deleted:0,mg_school_id:1,created_by: 1,updated_by: 1 
		  	}
		  	])

		  puts user.inspect
		end


	# create MgSchool
	# schoolId is = 1
       school = MgSchool.create([
							# 1
						   {id: 1, school_name: 'St Xaviers', school_code: 'GGPS',address_line1: 'chasa',address_line2:'Bokaro',country:'India',country_code:111,start_time:'8:00am',end_time:'3:30pm',street:'1st Street',city:'B S City',state:'JHARKHAND',pin_code:643215,landmark:'Gandhi Chowk',mobile_number:'04232518100',email_id:'ggps@yahoo.com',fax_number:'02354235',date_format:'%d/%m/%y',timezone:'Kolkata',currency_type:'Rs',affilicated_to:'CBSE',grading_system:1,reg_num:'STX/CBSE@2014',is_active:0,is_deleted:0 }
							
						   
						])
	

	# create MgModel
	model = MgModel.create([
							{ # 1
								id: 1 ,model_name: 'STUDENTS', description: 'STUDENT MODEL' ,index: 3},
							{ # 2
								id: 2 ,model_name: 'EMPLOYEES', description: 'EMPLOYEES MODEL' ,index:4},
							{ 
								# 3
								id: 3 ,model_name: 'CLASSES', description: 'CLASSES MODEL' ,index:2 
							},
							{ 
								# 4
								id: 4 ,model_name: 'EXAMINATION', description: 'EXAMINATION MODEL' ,index:8 
							},
							{ 
								# 5
								id: 5 ,model_name: 'FEES', description: 'FEES MODEL' ,index:11 
							},
							{ 
								# 7
								id: 7 ,model_name: 'EVENTS', description: 'EVENTS MODEL' ,index:10
							},
							{ 
								# 8
								id: 8 ,model_name: 'ASSIGNMENTS', description: 'ASSIGNMENTS MODEL' ,index:60
							},
							{ 
								# 9
								id: 9 ,model_name: 'TRANSPORT', description: 'TRANSPORT MODEL' ,index:60
							},
							{ 
								# 10
								id: 10 ,model_name: 'TIMETABLE', description: 'TIMETABLE MODEL' ,index:6 
							},
							{ 
								# 11
								id: 11 ,model_name: 'ATTENDANCES', description: 'ATTENDANCES MODEL' ,index:7
							},
							{ 
								# 12
								id: 12 ,model_name: 'HUMAN RESOURCE', description: 'HUMAN RESOURCE MODEL' ,index:100
							},
							{ 
								# 13
								id: 13 ,model_name: 'PARENTS', description: 'PARENTS MODEL' ,index:200
							},
							{ 
								# 14
								id: 14 ,model_name: 'SUBJECTS', description: 'SUBJECTS MODEL' ,index:5
							},
							{ 
								# 17
								id: 17 ,model_name: 'SCHOOLS', description: 'SCHOOLS MODEL' ,index:1
							},
							{ 
								# 18
								id: 18 , model_name: 'NOTIFICATIONS', description: 'NOTIFICATIONS MODEL' ,index:9 
							},
							{ 
								# 19
								id: 19 ,model_name: 'CURRICULUM', description: 'CURRICULUM MODEL' ,index:12 
							}
							
							])
	# create MgAction

	action = MgAction.create([
		{
			# 1
			id: 1 ,action_name:'view',description:'user able to view'
		},
		{
			# 2
			id: 2 ,action_name:'edit',description:'user able to edit'
		},
		{
			# 3
			id: 3 ,action_name:'create',description:'user able to create'
		},
		{
			# 4
			id: 4 ,action_name:'delete',description:'user able to delete'
		},
		{
			# 5
			id: 5 ,action_name:'update',description:'user able to update'
		}
		])


	MgRole.create([
	              { 
					# 1
	              	id: 1 ,role_name: 'admin', description: 'admin role'},
	              { 
					# 2
	              	id: 2 ,role_name: 'student', description: 'student role'},
	              { 
					# 3
	              	id: 3 ,role_name: 'employee', description: 'employee role'},
	              { 
					# 4
	              	id: 4 ,role_name: 'parent', description: 'parent role'},
	              { 
					# 5
	              	id: 5 ,role_name: 'principle', description: 'principle role'},
	              { 
					# 6
	              	id: 6 ,role_name: 'cloudadmin', description: 'cloudadmin role'},
	              { 
					# 7
	              	id: 7 ,role_name: 'teacher', description: 'teacher role'}
	              ])

	# MgUserRoles

	user_role = MgUserRole.create([
								{
								    # 1	 admin
								   id: 1,  mg_user_id: 1, mg_role_id: 1
								},
								{
									# 2  principle
								   id: 2,  mg_user_id: 2, mg_role_id: 5
								},
								{
									# 3  cloudadmin
									id: 3, mg_user_id: 3, mg_role_id: 6
								}
							])

	MgPermission.create([
						# STUDENTS	1-5
		                { id: 1,mg_model_id: 1, mg_action_id: 1},
						{ id: 2,mg_model_id: 1, mg_action_id: 2},
		                { id: 3,mg_model_id: 1, mg_action_id: 3},
						{ id: 4,mg_model_id: 1, mg_action_id: 4},
						{ id: 5,mg_model_id: 1, mg_action_id: 5},

						# PARENTS 6-10
						{ id: 6, mg_model_id: 11, mg_action_id: 1},
						{ id: 7, mg_model_id: 11, mg_action_id: 2},
						{ id: 8, mg_model_id: 11, mg_action_id: 3},
						{ id: 9, mg_model_id: 11, mg_action_id: 4},
						{ id: 10, mg_model_id: 11, mg_action_id: 5},

						# EVENTS 11-15
						{ id: 11, mg_model_id: 6, mg_action_id: 1},
						{id: 12, mg_model_id: 6, mg_action_id: 2},
						{id: 13, mg_model_id: 6, mg_action_id: 3},
						{id: 14,  mg_model_id: 6, mg_action_id: 4},
						{id: 15, mg_model_id: 6, mg_action_id: 5},

						# COURSES 16-20
						{id: 16,  mg_model_id: 3, mg_action_id: 1},
						{id: 17, mg_model_id: 3, mg_action_id: 2},
						{id: 18, mg_model_id: 3, mg_action_id: 3},
						{id: 19, mg_model_id: 3, mg_action_id: 4},
						{id: 20,mg_model_id: 3, mg_action_id: 5},

 
						# EMPLOYEES 21-25
						{id: 21, mg_model_id: 2, mg_action_id: 1},
						{id: 22, mg_model_id: 2, mg_action_id: 2},
						{id: 23, mg_model_id: 2, mg_action_id: 3},
						{id: 24, mg_model_id: 2, mg_action_id: 4},
						{id: 25, mg_model_id: 2, mg_action_id: 5},

						# NOTIFICATIONS 26-30
						{id: 26,  mg_model_id: 14, mg_action_id: 1},
						{id: 27, mg_model_id: 14, mg_action_id: 2},
						{id: 28,  mg_model_id: 14, mg_action_id: 3},
						{id: 29,  mg_model_id: 14, mg_action_id: 4},
						{id: 30, mg_model_id: 14, mg_action_id: 5},

						# FEES 31-35
						{id: 31, mg_model_id: 5, mg_action_id: 1},
						{id: 32, mg_model_id: 5, mg_action_id: 2},
						{id: 33,mg_model_id: 5, mg_action_id: 3},
						{id: 34, mg_model_id: 5, mg_action_id: 4},
						{id: 35,mg_model_id: 5, mg_action_id: 5},

						# SCHOOLS 36-40
						{id: 36, mg_model_id: 17, mg_action_id: 1},
						{id: 37,mg_model_id: 17, mg_action_id: 2},
						{id: 38, mg_model_id: 17, mg_action_id: 3},
						{id: 39, mg_model_id: 17, mg_action_id: 4},
						{id: 40, mg_model_id: 17, mg_action_id: 5},

						# TIMETABLE 41-45
						{ id: 41, mg_model_id: 10, mg_action_id: 1},
						{ id: 42, mg_model_id: 10, mg_action_id: 2},
						{ id: 43, mg_model_id: 10, mg_action_id: 3},
						{ id: 44, mg_model_id: 10, mg_action_id: 4},
						{ id: 45, mg_model_id: 10, mg_action_id: 5},


						#  46-50 
						{id: 46, mg_model_id: 9, mg_action_id: 1},
						{id: 47, mg_model_id: 9, mg_action_id: 2},
						{id: 48, mg_model_id: 9, mg_action_id: 3},
						{id: 49,  mg_model_id: 9, mg_action_id: 4},
						{id: 50, mg_model_id: 9, mg_action_id: 5},

						# EXAMINATION 51-55
						{id: 51, mg_model_id: 4, mg_action_id: 1},
						{id: 52,mg_model_id: 4, mg_action_id: 2},
						{id: 53,mg_model_id: 4, mg_action_id: 3},
						{id: 54,mg_model_id: 4, mg_action_id: 4},
						{id: 55,mg_model_id: 4, mg_action_id: 5},


						# NOTIFICATIONS 56-60
						{id: 56,mg_model_id: 18, mg_action_id: 1},
						{id: 57,mg_model_id: 18, mg_action_id: 2},
						{id: 58,mg_model_id: 18, mg_action_id: 3},
						{id: 59,mg_model_id: 18, mg_action_id: 4},
						{id: 60, mg_model_id: 18, mg_action_id: 5},


						# EVENTS 61-65
						{id: 61, mg_model_id: 7, mg_action_id: 1},
						{id: 62, mg_model_id: 7, mg_action_id: 2},
						{id: 63, mg_model_id: 7, mg_action_id: 3},
						{id: 64, mg_model_id: 7, mg_action_id: 4},
						{id: 65, mg_model_id: 7, mg_action_id: 5}])


				MgRolesPermission.create([
		                { id: 1 , mg_role_id: 1, mg_permission_id: 1},
		                { id: 2 , mg_role_id: 1, mg_permission_id: 2},
		                { id: 3 , mg_role_id: 1, mg_permission_id: 3},
		                { id: 4 , mg_role_id: 1, mg_permission_id: 4},
		                { id: 5 , mg_role_id: 1, mg_permission_id: 5},
		                { id: 6 , mg_role_id: 1, mg_permission_id: 6},
		                { id: 7 , mg_role_id: 1, mg_permission_id: 7},
		                { id: 8 , mg_role_id: 1, mg_permission_id: 8},
		                { id: 9 , mg_role_id: 1, mg_permission_id: 9},
		                { id: 10 , mg_role_id: 1, mg_permission_id: 10},
		                { id: 11 , mg_role_id: 1, mg_permission_id: 11},
		                { id: 12 , mg_role_id: 1, mg_permission_id: 12},
		                { id: 13 , mg_role_id: 1, mg_permission_id: 13},
		                { id: 14 , mg_role_id: 1, mg_permission_id: 14},
		                { id: 15 , mg_role_id: 1, mg_permission_id: 15},
		                { id: 16 , mg_role_id: 1, mg_permission_id: 16},
		                { id: 17 , mg_role_id: 1, mg_permission_id: 17},
		                { id: 18 , mg_role_id: 1, mg_permission_id: 18},
		                { id: 19 , mg_role_id: 1, mg_permission_id: 19},
		                { id: 20 , mg_role_id: 1, mg_permission_id: 20},
		                { id: 21 , mg_role_id: 1, mg_permission_id: 21},
		                { id: 22 , mg_role_id: 1, mg_permission_id: 22},
		                { id: 23 , mg_role_id: 1, mg_permission_id: 23},
		                { id: 24 , mg_role_id: 1, mg_permission_id: 24},
		                { id: 25 , mg_role_id: 1, mg_permission_id: 25},
		                { id: 26 , mg_role_id: 1, mg_permission_id: 26},
		                { id: 27 , mg_role_id: 1, mg_permission_id: 27},
		                { id: 28 , mg_role_id: 1, mg_permission_id: 28},
		                { id: 29 , mg_role_id: 1, mg_permission_id: 29},
		                { id: 30 , mg_role_id: 1, mg_permission_id: 30},
		                { id: 31 , mg_role_id: 1, mg_permission_id: 31},
		                { id: 32 , mg_role_id: 1, mg_permission_id: 32},
		                { id: 33 , mg_role_id: 1, mg_permission_id: 33},
		                { id: 34 , mg_role_id: 1, mg_permission_id: 34},
		                { id: 35 , mg_role_id: 1, mg_permission_id: 35},
		                { id: 36 , mg_role_id: 1, mg_permission_id: 36},
		                { id: 37 , mg_role_id: 1, mg_permission_id: 37},
		                { id: 38 , mg_role_id: 1, mg_permission_id: 38},
		                { id: 39 , mg_role_id: 1, mg_permission_id: 39},
		                { id: 40 , mg_role_id: 1, mg_permission_id: 40},
		                { id: 41 , mg_role_id: 1, mg_permission_id: 41},
		                { id: 42 , mg_role_id: 1, mg_permission_id: 42},
		                { id: 43 , mg_role_id: 1, mg_permission_id: 43},
		                { id: 44 , mg_role_id: 1, mg_permission_id: 44},
		                { id: 45 , mg_role_id: 1, mg_permission_id: 45},
		                { id: 46 , mg_role_id: 1, mg_permission_id: 46},
		                { id: 47 , mg_role_id: 1, mg_permission_id: 47},
		                { id: 48 , mg_role_id: 1, mg_permission_id: 48},
		                { id: 49 , mg_role_id: 1, mg_permission_id: 49},
		                { id: 50 , mg_role_id: 1, mg_permission_id: 50},
		                { id: 51 , mg_role_id: 1, mg_permission_id: 51},
		                { id: 52 , mg_role_id: 1, mg_permission_id: 52},
		                { id: 53 , mg_role_id: 1, mg_permission_id: 53},
		                { id: 54 , mg_role_id: 1, mg_permission_id: 54},
		                { id: 55 , mg_role_id: 1, mg_permission_id: 55},
		                { id: 56 , mg_role_id: 1, mg_permission_id: 56},
		                { id: 57 , mg_role_id: 1, mg_permission_id: 57},
		                { id: 58 , mg_role_id: 1, mg_permission_id: 58},
		                { id: 59 , mg_role_id: 1, mg_permission_id: 59},
		                { id: 60 , mg_role_id: 1, mg_permission_id: 60},
		                { id: 61 , mg_role_id: 1, mg_permission_id: 61},
		                { id: 62 , mg_role_id: 1, mg_permission_id: 62},
		                { id: 63 , mg_role_id: 1, mg_permission_id: 63},
		                { id: 64 , mg_role_id: 1, mg_permission_id: 64},
		                { id: 65 , mg_role_id: 1, mg_permission_id: 65},
		                { id: 66 ,mg_role_id: 6, mg_permission_id: 1},
		                { id: 67 ,mg_role_id: 6, mg_permission_id: 2},
		                { id: 68 ,mg_role_id: 6, mg_permission_id: 3},
		                { id: 69 ,mg_role_id: 6, mg_permission_id: 4},
		                { id: 70 ,mg_role_id: 6, mg_permission_id: 5},
		                { id: 71 ,mg_role_id: 6, mg_permission_id: 6},
		                { id: 72 ,mg_role_id: 6, mg_permission_id: 7},
		                { id: 73 ,mg_role_id: 6, mg_permission_id: 8},
		                { id: 74 ,mg_role_id: 6, mg_permission_id: 9},
		                { id: 75 ,mg_role_id: 6, mg_permission_id: 10},
		                { id: 76 ,mg_role_id: 6, mg_permission_id: 11},
		                { id: 77 ,mg_role_id: 6, mg_permission_id: 12},
		                { id: 78 ,mg_role_id: 6, mg_permission_id: 13},
		                { id: 79 ,mg_role_id: 6, mg_permission_id: 14},
		                { id: 80, mg_role_id: 6, mg_permission_id: 15},
		                { id: 81 ,mg_role_id: 6, mg_permission_id: 16},
		                { id: 82 ,mg_role_id: 6, mg_permission_id: 17},
		                { id: 83 ,mg_role_id: 6, mg_permission_id: 18},
		                { id: 84 ,mg_role_id: 6, mg_permission_id: 19},
		                { id: 85 ,mg_role_id: 6, mg_permission_id: 20},
		                { id: 86 ,mg_role_id: 6, mg_permission_id: 21},
		                { id: 87 ,mg_role_id: 6, mg_permission_id: 22},
		                { id: 88 ,mg_role_id: 6, mg_permission_id: 23},
		                { id: 89 ,mg_role_id: 6, mg_permission_id: 24},
		                { id: 90, mg_role_id: 6, mg_permission_id: 25},
		                { id: 91 ,mg_role_id: 6, mg_permission_id: 26},
		                { id: 92 ,mg_role_id: 6, mg_permission_id: 27},
		                { id: 93 ,mg_role_id: 6, mg_permission_id: 28},
		                { id: 94 ,mg_role_id: 6, mg_permission_id: 29},
		                { id: 95 ,mg_role_id: 6, mg_permission_id: 30},
		                { id: 96 ,mg_role_id: 6, mg_permission_id: 31},
		                { id: 97 ,mg_role_id: 6, mg_permission_id: 32},
		                { id: 98 ,mg_role_id: 6, mg_permission_id: 33},
		                { id: 99 ,mg_role_id: 6, mg_permission_id: 34},
		                { id: 100, mg_role_id: 6, mg_permission_id: 35},
		                { id: 101 ,mg_role_id: 6, mg_permission_id: 36},
		                { id: 102 ,mg_role_id: 6, mg_permission_id: 37},
		                { id: 103 ,mg_role_id: 6, mg_permission_id: 38},
		                { id: 104 ,mg_role_id: 6, mg_permission_id: 39},
		                { id: 105 ,mg_role_id: 6, mg_permission_id: 40},
		                { id: 106 ,mg_role_id: 6, mg_permission_id: 41},
		                { id: 107 ,mg_role_id: 6, mg_permission_id: 42},
		                { id: 108 ,mg_role_id: 6, mg_permission_id: 43},
		                { id: 109 ,mg_role_id: 6, mg_permission_id: 44},
		                { id: 110, mg_role_id: 6, mg_permission_id: 45},
		                { id: 111 ,mg_role_id: 6, mg_permission_id: 46},
		                { id: 112 ,mg_role_id: 6, mg_permission_id: 47},
		                { id: 113 ,mg_role_id: 6, mg_permission_id: 48},
		                { id: 114 ,mg_role_id: 6, mg_permission_id: 49},
		                { id: 115 ,mg_role_id: 6, mg_permission_id: 50},
		                { id: 116 ,mg_role_id: 6, mg_permission_id: 51},
		                { id: 117 ,mg_role_id: 6, mg_permission_id: 52},
		                { id: 118 ,mg_role_id: 6, mg_permission_id: 53},
		                { id: 119 ,mg_role_id: 6, mg_permission_id: 54},
		                { id: 120, mg_role_id: 6, mg_permission_id: 55},
		                { id: 121 ,mg_role_id: 6, mg_permission_id: 56},
		                { id: 122 ,mg_role_id: 6, mg_permission_id: 57},
		                { id: 123 ,mg_role_id: 6, mg_permission_id: 58},
		                { id: 124 ,mg_role_id: 6, mg_permission_id: 59},
		                { id: 125 ,mg_role_id: 6, mg_permission_id: 60},
		                { id: 126 ,mg_role_id: 6, mg_permission_id: 61},
		                { id: 127 ,mg_role_id: 6, mg_permission_id: 62},
		                { id: 128 ,mg_role_id: 6, mg_permission_id: 63},
		                { id: 129 ,mg_role_id: 6, mg_permission_id: 64},
		                { id: 130, mg_role_id: 6, mg_permission_id: 65},
		                { id: 131 ,mg_role_id: 2, mg_permission_id: 1},
		                { id: 132 ,mg_role_id: 2, mg_permission_id: 2},
		                { id: 133 ,mg_role_id: 2, mg_permission_id: 3},
		                { id: 134 ,mg_role_id: 2, mg_permission_id: 4},
		                { id: 135 ,mg_role_id: 2, mg_permission_id: 5},
		                { id: 136 , mg_role_id: 4, mg_permission_id: 1},
		                { id: 137 , mg_role_id: 4, mg_permission_id: 2},
		                { id: 138 , mg_role_id: 4, mg_permission_id: 3},
		                { id: 139 , mg_role_id: 4, mg_permission_id: 4},
		                { id: 140, mg_role_id: 4, mg_permission_id: 5},
		                { id: 141 ,mg_role_id: 7, mg_permission_id: 1},
		                { id: 142 ,mg_role_id: 7, mg_permission_id: 2},
		                { id: 143 ,mg_role_id: 7, mg_permission_id: 3},
		                { id: 144 ,mg_role_id: 7, mg_permission_id: 4},
		                { id: 145 ,mg_role_id: 7, mg_permission_id: 5},
		                { id: 146 ,mg_role_id: 3, mg_permission_id: 16},
		                { id: 147 ,mg_role_id: 3, mg_permission_id: 17},
		                { id: 148 ,mg_role_id: 3, mg_permission_id: 18},
		                { id: 149 ,mg_role_id: 3, mg_permission_id: 19},
		                { id: 150, mg_role_id: 3, mg_permission_id: 20},		                
		                { id: 151 ,mg_role_id: 3, mg_permission_id: 21},
		                { id: 152 ,mg_role_id: 3, mg_permission_id: 22},
		                { id: 153 ,mg_role_id: 3, mg_permission_id: 23},
		                { id: 154 ,mg_role_id: 3, mg_permission_id: 24},
		                { id: 155 ,mg_role_id: 3, mg_permission_id: 25},
						{ id: 156 ,mg_role_id: 5, mg_permission_id: 1},
		                { id: 157 ,mg_role_id: 5, mg_permission_id: 2},
		                { id: 158 ,mg_role_id: 5, mg_permission_id: 3},
		                { id: 159 ,mg_role_id: 5, mg_permission_id: 4},
		                { id: 160, mg_role_id: 5, mg_permission_id: 5},
		                { id: 161 ,mg_role_id: 5, mg_permission_id: 6},
		                { id: 162 ,mg_role_id: 5, mg_permission_id: 7},
		                { id: 163 ,mg_role_id: 5, mg_permission_id: 8},
		                { id: 164 ,mg_role_id: 5, mg_permission_id: 9},
		                { id: 165 ,mg_role_id: 5, mg_permission_id: 10},
						{ id: 166 ,mg_role_id: 5, mg_permission_id: 31},
		                { id: 167 ,mg_role_id: 5, mg_permission_id: 32},
		                { id: 168 ,mg_role_id: 5, mg_permission_id: 33},
		                { id: 169 ,mg_role_id: 5, mg_permission_id: 34},
		                { id: 170, mg_role_id: 5, mg_permission_id: 35},
						{ id: 171 ,mg_role_id: 5, mg_permission_id: 55},
		                { id: 172 ,mg_role_id: 5, mg_permission_id: 56},
		                { id: 173 ,mg_role_id: 5, mg_permission_id: 57},
		                { id: 174 ,mg_role_id: 5, mg_permission_id: 58},
		                { id: 175 ,mg_role_id: 5, mg_permission_id: 59},
		                { id: 176 ,mg_role_id: 5, mg_permission_id: 60},
		                { id: 177 ,mg_role_id: 5, mg_permission_id: 61},
		                { id: 178 ,mg_role_id: 5, mg_permission_id: 62},
		                { id: 179 ,mg_role_id: 5, mg_permission_id: 63},
		                { id: 180, mg_role_id: 5, mg_permission_id: 64},
		                { id: 181, mg_role_id: 5, mg_permission_id: 65}


		                ])

#   Mayor.create(name: 'Emanuel', city: cities.first)	

	principle = MgEmployee.create([{
				id: 1,
				mg_nationality_id:2,
				mg_user_id:1,
				mg_school_id:1,
				employee_number:"P1",
				first_name:"Piyush",
				middle_name:"Ranjan",
				last_name:"Singh",
				gender: "male",
				job_title:"principal",
				qualification:"M-Tech",
				experience_detail:"Previouly work in St. Lord Collage",
				experience_year:10,
				experience_month:4,
				status:0,
				status_description:"Very good personality",
				date_of_birth:"2015-01-08",
				marital_status: "single",
				father_name:"Raju",
				mother_name:"Ramvati",
				blood_group:"B+",
				emergency_contact_name:"Shailendr Singh",
				emergency_contact_number:9741974133,
				language: "Hindi",
				is_deleted: 0
		}])

	email = MgEmail.create([
			{
				id:1,
				mg_email_id:"ssingh@mindcomgroup",
				email_type:"home",
				notification:0,
				subscription:0,
				mg_user_id:2,
				is_deleted:0
			}
		])

	adress = MgAddress.create([
			{
				id: 1, 
				address_line1: "A-45", 
				address_line2: "red lime road", 
				address_type: "Permanent", 
				city: "Bangalore", 
				state: "Karnataka", 
				country: "India", 
				pin_code: "560032", 
				country_code: 2, 
				mg_school_id: 1, 
				mg_user_id: 2, 
				is_deleted: 0, 
				notification: 0, 
				subscription: 0, 
				created_by:1 , 
				updated_by: 1, 			 
				street: "Redlime street",
				landmark: "Fountain" 
			}
		])

	phone = MgPhone.create([
		{
			id:1 , 
			phone_number: "2580758", 
			phone_type: "phone", 
			notification: 0, 
			subscription: 0, 
			mg_user_id: 2, 
			is_deleted: 0, 
			created_by: 1, 
			updated_by: 1
			},
			{
			id:2 , 
			phone_number: "9876541230", 
			phone_type: "mobile", 
			notification: 0, 
			subscription: 0, 
			mg_user_id: 2, 
			is_deleted: 0, 
			created_by: 1, 
			updated_by: 1
			}
		])

	grading_system = MgExamSystem.create([
			{
				id:1 , 
				mg_school_id:1 , 
				grading_system: 1, 
				description: "CCE Grading System", 
				is_enabled: 0, 
				is_deleted: 0, 
				grading_name: "CCE"
			},
			{
				id:2 , 
				mg_school_id:1 , 
				grading_system: 2, 
				description: "CCW Grading System", 
				is_enabled: 0, 
				is_deleted: 0, 
				grading_name: "CCW"
			},
			{
				id:3 , 
				mg_school_id:1 , 
				grading_system: 3, 
				description: "GPA Grading System", 
				is_enabled: 0, 
				is_deleted: 0, 
				grading_name: "GPA"
			}
		])


	emp_category = MgEmployeeCategory.create([
					{
						id:1,
						category_name:"Non Teaching Staff",
						prefix:"NTS",
						suffix:"staff",
						status:0,
						is_deleted:0,
						mg_school_id:1
					},
					{
						id:2,
						category_name:"Teaching Staff",
						prefix:"TS",
						suffix:"teacher",
						status:0,
						is_deleted:0,
						mg_school_id:1
					}
					])

