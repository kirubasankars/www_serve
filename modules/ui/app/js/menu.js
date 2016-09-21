define(function () {
    return {
        childs: [
            {
                title: 'Contact'
            },
            {
              title : 'Sales',
              href: '#/sales/list',
            },
            {
                title: 'User',
                href: '#/user/list',
                childs: [
                    {
                        title: 'company',
                        href: '#/contact/list'
                    },
                    {
                        title: 'company',
                        childs: [
                            {
                                title: 'company'
                            }, {
                                title: 'company'
                            }
                        ]
                    }
                ]
            }
        ]
    };
})
