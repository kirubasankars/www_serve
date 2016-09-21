define(function () {

    return {
        contact: {
            ui: 'PW',
            list: { url: 'http://localhost:5984/test/_design/views/_view/customers?include_docs=true' },
            view: { url: 'api/contact?id={id}' },
            save: { url: 'api/contact' },
            lookup : {
              fields : [
                { value: 'id', description: 'Id' },
                { value: 'name', description: 'Name' }
              ],
              url: 'api/contact'
            }
        },
        sales: {
            ui: 'SW',
            list: { url: 'api/sales' },
            view: { url: 'api/sales?id={id}' },
            save: { url: 'api/sales' }
        },
        product : {
          lookup : {
            fields : [
              { value: 'id', description: 'Id' },
              { value: 'name', description: 'Name' }
            ],
            url: 'api/product'
          }
        },
        company : {
          lookup : {
            fields : [
              { value: 'id', description: 'Id' },
              { value: 'name', description: 'Name' }
            ],
            url: 'api/contact/company'
          }
        }
    };

});
