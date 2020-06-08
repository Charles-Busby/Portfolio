Select 
    oe_hdr.company_id as 'Company'
    ,oe_hdr.order_no as 'Order Number'
    ,oe_hdr.location_id as 'Company Location'
    ,oe_hdr.customer_id as 'Customer'
    ,inv_mast.item_id as 'Item'
    ,service_inv_mast.serial_number as 'Site'
    ,concat(
        contacts.first_name
        , ' '
        , contacts.last_name) as 'Name'
    ,oe_line_service_labor.hours_charged as 'Hours'
    ,oe_line_service_labor.unit_price as 'Price'
    ,oe_line_service_labor.extended_price as 'Extended Price'
    ,service_labor.service_labor_id as 'Labor'
    ,service_labor.service_labor_desc as 'Labor Description'
    ,oe_line_service_labor.labor_type_cd
    ,case
           when
               oe_line_service_labor.labor_type_cd = 1748
               --(total_hours < 40) or (oe_line_service_labor.hours_charged < 12)
           then
               oe_line_service_labor.hours_charged*(service_technician.hourly_cost+service_technician.burdened_cost)
           else
               oe_line_service_labor.hours_charged*(service_technician.overtime_hourly_cost+service_technician.burdened_cost)
    end as 'Cost'
from oe_hdr

left join oe_line
    on oe_line.order_no = oe_hdr.order_no

left join oe_line_service
    on oe_line_service.oe_line_uid = oe_line.oe_line_uid 

left join oe_line_service_labor
    on oe_line_service_labor.oe_line_service_uid = oe_line_service.oe_line_service_uid

left join service_labor
    on service_labor.service_labor_uid = oe_line_service_labor.service_labor_uid

inner join service_technician
    on service_technician.service_technician_uid = oe_line_service_labor.service_technician_uid

left join contacts
    on contacts.id = service_technician.contacts_id

/*left join 
    select(
        sum(oe_line_service_labor.hours_charged)
        ,service_technician.contacts_id
    from oe_line_service_labor
    inner join service_technician
        on service_technician.service_technician_uid = oe_line_service_labor.service_technician_uid
    group by */

inner join service_inv_mast
    on service_inv_mast.service_inv_mast_uid = oe_line_service.service_inv_mast_uid

inner join inv_mast
    on inv_mast.inv_mast_uid = service_inv_mast.inv_mast_uid

WHERE oe_hdr.order_no = '61004264'
