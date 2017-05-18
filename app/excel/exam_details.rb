class ExamDetails < WriteXLSX

	def initialize(mg_school_id, mg_examination_detail_id)
		@school=MgSchool.find(mg_school_id)
		@@school_logo=@school.logo.url(:medium, timestamp: false)
		@examination_detail = MgExaminationDetail.find_by(:id=>mg_examination_detail_id)
		@exam_plan=MgExamSeatingPlan.where(:is_deleted=>0,:mg_school_id=>mg_school_id, :mg_examination_detail_id=>mg_examination_detail_id)
	  	@mg_school_id=mg_school_id
	  	excel
	  	# excel1
	end
	
	def excel

		workbook  = WriteXLSX.new(File.join(Rails.root, "public/xlsx_files", "exam_excel.xlsx"))
	    w = workbook.add_worksheet
	    heading = workbook.add_format(:align => 'center', :bold => 1)
	    heading_center = workbook.add_format(:align => 'center', :bold => 1, :fg_color=>'silver')
	    heading_center_title = workbook.add_format(:align => 'center', :bold => 1, :fg_color=>'silver', :size=>'16')
	    heading_left = workbook.add_format(:align => 'left', :bold => 1, :fg_color=>'silver')
	    heading_value = workbook.add_format(:align => 'left')
	    school_name = workbook.add_format(:align => 'left', :bold => 1, :size=>'16')
	    w.set_column(0, 0, 23)
	    w.set_column(1, 100, 20)
	    w.set_row(2, 40)
	    w.set_row(5, 30)

	    w.insert_image(1, 0, File.exists?("#{Rails.root}/public/#{@@school_logo}") ? "#{Rails.root}/public/#{@@school_logo}" : File.join(Rails.root, "app/assets/images", "logo.jpg"), x=0, y=0, x_scale=0.4, y_scale=0.4)

	    text_format = workbook.add_format(
	        :bold   => 1,
	        # :italic => 1,
	        :color  => 'blue',
	        # :fg_color=>'blue',
	        :size   => 16,
	        :font   => 'Lucida Calligraphy'
	    )
	    text_format1= workbook.add_format(
	        :bold   => 1,
	        # :italic => 1,
	        # :color  => 'red',
	        :size   => 14,
	        :font   => 'Lucida Calligraphy'
	    )
	    # headings = ['Gate Pass', '']
	    # w.write_row('E1', headings, heading)

	    school_name_headings = [@school.try(:school_name), "","","","",""]
	    w.write_row('B3', school_name_headings, text_format)
	    

	    headings = ['', '','','Student Details','','',""]
	    w.write_row('A6', headings, heading_center_title)
	 #    data = [
		#     [ 'Apples',  10000, 5000, 8000, 6000 ],
		#     [ 'Pears',   2000,  3000, 4000, 5000 ],
		#     [ 'Bananas', 6000,  6000, 6500, 6000 ],
		#     [ 'Oranges', 500,   300,  200,  700 ]
		# ]
		
		
	    
	    # coloumn_count=0
	    # row_number=7
	    # w.write(row_number, coloumn_count, 'Sr. No',heading_left)
	    # w.write(row_number, coloumn_count+=1, 'Room Number',heading_left)
	    # w.write(row_number, coloumn_count+=1, 'Date',heading_left)
	    # w.write(row_number, coloumn_count+=1, 'Start Time',heading_left)
	    # w.write(row_number, coloumn_count+=1, 'End Time',heading_left)
	    # w.write(row_number, coloumn_count+=1, 'Admission Number',heading_left)
	    # w.write(row_number, coloumn_count+=1, 'Student Name',heading_left)

	    table_data=[]
	    count=0
	    @exam_plan.order(:mg_institute_room_id).each do |s|
		    s.mg_exam_seating_plan_details.where(:is_deleted=>0, :mg_school_id=>@mg_school_id).each do |ss|
		      	student=MgStudent.find_by(:id=>ss.mg_student_id)
	    		table_data.push([count+=1,MgInstituteRoom.find_by(:id=>s.try(:mg_institute_room_id)).try(:room_no),s.try(:date).present? ? s.try(:date).strftime(@school.try(:date_format)) : "",s.try(:start_time).present? ? s.try(:start_time).strftime('%I:%M%p') : "",s.try(:end_time).present? ? s.try(:end_time).strftime('%I:%M%p') : "",student.try(:admission_number), student.try(:first_name).to_s+" "+student.try(:last_name).to_s])
	    	end
		end

	    w.add_table(
		    "A8:G#{8+table_data.length}",
		    {
		        :data    => table_data,
		        :columns => [
		            { :header => 'Sr. No' },
		            { :header => 'Room Number' },
		            { :header => 'Date' },
		            { :header => 'Start Time' },
		            { :header => 'End Time' },
		            { :header => 'Admission Number' },
		            {:header  => 'Student Name'}
		        ],
		        :autofilter => 10

		    }
		)

	    workbook.close
	end

	def excel1
		workbook    = WriteXLSX.new(File.join(Rails.root, "public/xlsx_files", "exam_excel.xlsx"))
worksheet1  = workbook.add_worksheet
worksheet2  = workbook.add_worksheet
worksheet3  = workbook.add_worksheet
worksheet4  = workbook.add_worksheet
worksheet5  = workbook.add_worksheet
worksheet6  = workbook.add_worksheet
worksheet7  = workbook.add_worksheet
worksheet8  = workbook.add_worksheet
worksheet9  = workbook.add_worksheet
worksheet10 = workbook.add_worksheet
worksheet11 = workbook.add_worksheet
worksheet12 = workbook.add_worksheet

currency_format = workbook.add_format(:num_format => '$#,##0')


# Some sample data for the table.
data = [
    [ 'Apples',  10000, 5000, 8000, 6000 ],
    [ 'Pears',   2000,  3000, 4000, 5000 ],
    [ 'Bananas', 6000,  6000, 6500, 6000 ],
    [ 'Oranges', 500,   300,  200,  700 ]
]

###############################################################################
#
# Example 1.
#
caption = 'Default table with no data.'

# Set the columns widths.
worksheet1.set_column('B:G', 12)

# Write the caption.
worksheet1.write('B1', caption)

# Add a table to the worksheet.
worksheet1.add_table('B3:F7')


###############################################################################
#
# Example 2.
#
caption = 'Default table with data.';

# Set the columns widths.
worksheet2.set_column('B:G', 12)

# Write the caption.
worksheet2.write('B1', caption)

# Add a table to the worksheet.
worksheet2.add_table('B3:F7', { :data => data })


###############################################################################
#
# Example 3.
#
caption = 'Table without default autofilter.'

# Set the columns widths.
worksheet3.set_column('B:G', 12)

# Write the caption.
worksheet3.write('B1', caption)

# Add a table to the worksheet.
worksheet3.add_table('B3:F7', { :autofilter => 0 })

# Table data can also be written separately, as an array or individual cells.
worksheet3.write_col('B4', data)

###############################################################################
#
# Example 4.
#
caption = 'Table without default header row.'

# Set the columns widths.
worksheet4.set_column('B:G', 12)

# Write the caption.
worksheet4.write('B1', caption)

# Add a table to the worksheet.
worksheet4.add_table('B4:F7', { :header_row => 0 })

# Table data can also be written separately, as an array or individual cells.
worksheet4.write_col('B4', data)

###############################################################################
#
# Example 5.
#
caption = 'Default table with "First Column" and "Last Column" options.'

# Set the columns widths.
worksheet5.set_column('B:G', 12)

# Write the caption.
worksheet5.write('B1', caption)

# Add a table to the worksheet.
worksheet5.add_table('B3:F7', { :first_column => 1, :last_column => 1 })

# Table data can also be written separately, as an array or individual cells.
worksheet5.write_col('B4', data)

###############################################################################
#
# Example 6.
#
caption = 'Table with banded columns but without default banded rows.';

# Set the columns widths.
worksheet6.set_column('B:G', 12)

# Write the caption.
worksheet6.write('B1', caption)

# Add a table to the worksheet.
worksheet6.add_table('B3:F7', { :banded_rows => 0, :banded_columns => 1 })

# Table data can also be written separately, as an array or individual cells.
worksheet6.write_col('B4', data)


###############################################################################
#
# Example 7.
#
caption = 'Table with user defined column headers';

# Set the columns widths.
worksheet7.set_column('B:G', 12)

# Write the caption.
worksheet7.write('B1', caption)

# Add a table to the worksheet.
worksheet7.add_table(
    'B3:F7',
    {
        :data    => data,
        :columns => [
            { :header => 'Product' },
            { :header => 'Quarter 1' },
            { :header => 'Quarter 2' },
            { :header => 'Quarter 3' },
            { :header => 'Quarter 4' }
        ]
    }
)

###############################################################################
#
# Example 8.
#
caption = 'Table with user defined column headers';

# Set the columns widths.
worksheet8.set_column('B:G', 12)

# Write the caption.
worksheet8.write('B1', caption)

# Add a table to the worksheet.
worksheet8.add_table(
    'B3:G7',
    {
        :data    => data,
        :columns => [
            { :header => 'Product' },
            { :header => 'Quarter 1' },
            { :header => 'Quarter 2' },
            { :header => 'Quarter 3' },
            { :header => 'Quarter 4' },
            {
                :header  => 'Year',
                :formula => '=SUM(Table8[@[Quarter 1]:[Quarter 4]])'
            }
        ]
    }
)


###############################################################################
#
# Example 9.
#
caption = 'Table with totals row (but no caption or totals).';

# Set the columns widths.
worksheet9.set_column('B:G', 12)

# Write the caption.
worksheet9.write('B1', caption)

# Add a table to the worksheet.
worksheet9.add_table(
    'B3:G8',
    {
        :data      => data,
        :total_row => 1,
        :columns   => [
            { :header => 'Product' },
            { :header => 'Quarter 1' },
            { :header => 'Quarter 2' },
            { :header => 'Quarter 3' },
            { :header => 'Quarter 4' },
            {
                :header  => 'Year',
                :formula => '=SUM(Table8[@[Quarter 1]:[Quarter 4]])'
            }
        ]
    }
)


###############################################################################
#
# Example 10.
#
caption = 'Table with totals row with user captions and functions.';

# Set the columns widths.
worksheet10.set_column('B:G', 12)

# Write the caption.
worksheet10.write('B1', caption)

# Add a table to the worksheet.
worksheet10.add_table(
    'B3:G8',
    {
        :data      => data,
        :total_row => 1,
        :columns   => [
            { :header => 'Product',   :total_string   => 'Totals' },
            { :header => 'Quarter 1', :total_function => 'sum' },
            { :header => 'Quarter 2', :total_function => 'sum' },
            { :header => 'Quarter 3', :total_function => 'sum' },
            { :header => 'Quarter 4', :total_function => 'sum' },
            {
                :header         => 'Year',
                :formula        => '=SUM(Table8[@[Quarter 1]:[Quarter 4]])',
                :total_function => 'sum'
            }
        ]
    }
)


###############################################################################
#
# Example 11.
#
caption = 'Table with alternative Excel style.';

# Set the columns widths.
worksheet11.set_column('B:G', 12)

# Write the caption.
worksheet11.write('B1', caption)

# Add a table to the worksheet.
worksheet11.add_table(
    'B3:G8',
    {
        :data      => data,
        :style     => 'Table Style Light 11',
        :total_row => 1,
        :columns   => [
            { :header => 'Product',   :total_string   => 'Totals' },
            { :header => 'Quarter 1', :total_function => 'sum' },
            { :header => 'Quarter 2', :total_function => 'sum' },
            { :header => 'Quarter 3', :total_function => 'sum' },
            { :header => 'Quarter 4', :total_function => 'sum' },
            {
                :header         => 'Year',
                :formula        => '=SUM(Table8[@[Quarter 1]:[Quarter 4]])',
                :total_function => 'sum'
            }
        ]
    }
)


###############################################################################
#
# Example 12.
#
caption = 'Table with column formats.';

# Set the columns widths.
worksheet12.set_column('B:G', 12)

# Write the caption.
worksheet12.write('B1', caption)

# Add a table to the worksheet.
worksheet12.add_table(
    'B3:G8',
    {
        :data      => data,
        :total_row => 1,
        :columns   => [
            { :header => 'Product', :total_string => 'Totals' },
            {
                :header         => 'Quarter 1',
                :total_function => 'sum',
                :format         => currency_format,
            },
            {
                :header         => 'Quarter 2',
                :total_function => 'sum',
                :format         => currency_format,
            },
            {
                :header         => 'Quarter 3',
                :total_function => 'sum',
                :format         => currency_format,
            },
            {
                :header         => 'Quarter 4',
                :total_function => 'sum',
                :format         => currency_format,
            },
            {
                :header         => 'Year',
                :formula        => '=SUM(Table8[@[Quarter 1]:[Quarter 4]])',
                :total_function => 'sum',
                :format         => currency_format,
            }
        ]
    }
)

workbook.close
		
	end
end 
