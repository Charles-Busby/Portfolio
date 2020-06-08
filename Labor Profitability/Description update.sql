update gl set description = invoice_hdr.bill2_name,
    date_last_modified = getdate(),
    last_maintained_by = 'sql fix Customer description'
from gl

INNER JOIN invoice_hdr
	on invoice_hdr.invoice_no = gl.source
	
WHERE (gl.account_number = '40000010'
	AND gl.year_for_period = '2020')
	OR 
	(gl.account_number = '40000020'
	AND gl.year_for_period = '2020')
	OR
	(gl.account_number = '45000010'
	AND gl.year_for_period = '2020')
	OR
	(gl.account_number = '45000020'
	AND gl.year_for_period = '2020')