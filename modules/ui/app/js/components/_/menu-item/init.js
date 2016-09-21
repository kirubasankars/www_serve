define(['jquery', 'knockout'], function ($, ko) {

    $(document).on('click', '.menu-item.child-closed', function (e) {
        $(this).removeClass('child-closed').addClass('child-open');
        e.stopPropagation();
    });

    $(document).on('click', '.menu-item.child-open', function (e) {
        $(this).removeClass('child-open').addClass('child-closed');
        e.stopPropagation();
    });

    $(document).on('click', '.menu-item.child-open', function (e) {
        $(this).removeClass('child-open').addClass('child-closed');
        e.stopPropagation();
    });

    $(document).on('click', '.menu-item', function (e) {
        $('.menu-item.active').removeClass('active');
        $(this).addClass('active');
        if ($('.title', this).attr('dhref')) {
            window.location.href = $('.title', this).attr('dhref');
        }
        e.stopPropagation();
    });

    return function (params) {
        this.emptyBoxes = [];
        this.data = params.data;
        this.level = params.level;
        for (var i = 0; i < params.level; i++) {
            this.emptyBoxes.push({});
        }
    }
});
