select gl.description as "Customer",
    gl.period,
    gl.year_for_period,
    gl.account_number,
    gl.source,
    case
        when
            cast(right(gl.account_number, 3) as INT) = 010
        then
            10
        when
            cast(right(gl.account_number, 3) as INT) = 011
        then
            11
        when
            cast(right(gl.account_number, 3) as INT) = 020
        then
            20
        else
            00
    end as "Branch",
    case
        when
            cast(left(gl.account_number,5) as INT) = 40000
        then
            -gl.amount
        else
            0
    end as 'Parts Revenue',
    case
        when
            cast(left(gl.account_number,5) as INT) = 45000
        then
            -gl.amount
        else
            0
    end as 'Labor Revenue',
    case
        when 
            cast(left(gl.account_number,5) as INT) = 50000
        then
            gl.amount
        else
            0
    end as 'COG',
    case
        when
            cast(left(gl.account_number,5) as INT) = 50500
        then
            gl.amount
        else
            0
    end as 'Cost of Labor'
from gl

where ((cast(left(gl.account_number,5) as INT) = 40000)
    or (cast(left(gl.account_number,5) as INT) = 45000)
    or (cast(left(gl.account_number,5) as INT) = 50000)
    or (cast(left(gl.account_number,5) as INT) = 50500))
    and (gl.journal_id ='SJ')
    and gl.year_for_period>=2020
    and gl.company_no=1
