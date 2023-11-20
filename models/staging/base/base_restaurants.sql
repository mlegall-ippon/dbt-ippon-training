select 
    identifier as restau_id
    , name as name
    , address as address
    , nb_employees as nb_employees
    , open_on_sunday as open_on_sunday
from 
    {{ source('SOURCE', 'restaurants') }}