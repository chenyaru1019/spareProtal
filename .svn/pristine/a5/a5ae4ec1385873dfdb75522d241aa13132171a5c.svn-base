//待办
app.controller('MyUnfinishedWorkItemController', ['$scope', '$rootScope', "$translate", "$http", "$state", "$compile", "$interval", "ControllerConfig", "jq.datables",
    function ($scope, $rootScope, $translate, $http, $state, $compile, $interval, ControllerConfig, jqdatables) {
        var PortalRoot = window.localStorage.getItem("H3.PortalRoot");
        $scope.searchKey = "";
        //进入视图触发
        $scope.$on('$viewContentLoaded', function (event) {
            $scope.searchKey = "";
        });
        // 获取语言
        $rootScope.$on('$translateChangeEnd', function () {
            $scope.getLanguage();
            $state.go($state.$current.self.name, {}, { reload: true });
        });

        $scope.getLanguage = function () {
            $scope.LanJson = {
                search: $translate.instant("uidataTable.search"),
                sLengthMenu: $translate.instant("uidataTable.sLengthMenu"),
                sZeroRecords: $translate.instant("uidataTable.sZeroRecords_UnfinishedWorkItem"),
                sInfo: $translate.instant("uidataTable.sInfo"),
                sProcessing: $translate.instant("uidataTable.sProcessing")
            }
        }
        $scope.getLanguage();

        // 获取列定义
        $scope.getColumns = function () {
            var columns = [];
            //操作
            columns.push({
                "mData": "Priority",
                "sClass": "hide1024",
                "mRender": function (data, type, full, a) {
                    var rtnstring = "";
                    //紧急程度
                    // if (full.Priority == "0") {
                    //     rtnstring = "<i class=\"glyphicon glyphicon-bell\" ></i>";
                    // } else if (full.Priority == "1") {
                    //     rtnstring = "<i class=\"glyphicon glyphicon-bell\" style=\"color:green;\"></i>";
                    // } else {
                    //     rtnstring = "<i class=\"glyphicon glyphicon-bell\" style=\"color:red;\"></i>";
                    // }
                    // //是否催办
                    // if (full.Urged == false) {
                    //     rtnstring = rtnstring + "<a> <i class=\"glyphicon glyphicon-bullhorn\"></i></a>";
                    // } else {
                    //     rtnstring = rtnstring + "<a ng-click=\"showUrgeWorkItemInfoModal('" + full.ObjectID + "')\"> <i class=\"glyphicon glyphicon-bullhorn\" style=\"color:orangered;\"></i></a>";
                    // }
                    return  "<a ui-toggle-class='show' target='.app-aside-right' targeturl='WorkItemSheets.html?WorkItemID=" + full.ObjectID + "'>处理</a></td>";;
                }
            });
            //流程名称
            columns.push({
                "mData": "InstanceName",
                "mRender": function (data, type, full) {
                    return "<td>" + data + "</a></td>";
                }
            });

            //编号
            columns.push({
                "mData": "OperationNumber",
                "mRender": function (data, type, full) {
                    return "<td>" + data + "</a></td>";
                }
            });

            //项目简称
            columns.push({
                "mData": "ProjectAbbreviation",
                "mRender": function (data, type, full) {
                    return "<td>" + data + "</a></td>";
                }
            });

            //任务名称
            columns.push({
                "mData": "DisplayName",
                "mRender": function (data, type, full) {
                    //打开流程状态
                    data = data != "" ? data : full.ActivityCode;
                    return "<td><a href='index.html#/InstanceDetail/" + full.InstanceId + "/" + full.ObjectID + "/" + "/' target='_blank'>" + data + "</a></td>";
                }
            });
            //接收时间
            columns.push({ "mData": "ReceiveTime", "sClass": "center hide414" });
            //发起人
            columns.push({
                "mData": "OriginatorName",
                "sClass": "hide414",
                "mRender": function (data, type, full) {
                    return "<a ng-click=\"showUserInfoModal('" + full.Originator + "');\" new-Bindcompiledhtml>" + data + "</a>";
                }
            });
            //发起人所属组织
            columns.push({ "mData": "OriginatorOUName", "sClass": "hide1024" });
            return columns;
        }

        $scope.options = function () {
            var options = {
                "bProcessing": true,
                "bServerSide": true,    // 是否读取服务器分页
                "paging": true,         // 是否启用分页
                "bPaginate": true,      // 分页按钮
                "bLengthChange": false, // 每页显示多少数据
                "bFilter": false,        // 是否显示搜索栏  
                "searchDelay": 1000,    // 延迟搜索
                "iDisplayLength": 10,   // 每页显示行数  
                "bSort": false,         // 排序
                "singleSelect": true,
                "bInfo": true,          // Showing 1 to 10 of 23 entries 总记录数没也显示多少等信息  
                "pagingType": "full_numbers",  // 设置分页样式，这个是默认的值
                "language": {           // 语言设置
                    "sLengthMenu": $scope.LanJson.sLengthMenu,
                    "sZeroRecords": "<i class=\"icon-emoticon-smile\"></i>" + $scope.LanJson.sZeroRecords,
                    "sInfo": $scope.LanJson.sInfo,
                    "infoEmpty": "",
                    "sProcessing": $scope.LanJson.sProcessing,
                    "paginate": {
                        "first": "<<",
                        "last": ">>",
                        "previous": "<",
                        "next": ">"
                    }
                },
                "sAjaxSource": ControllerConfig.WorkItem.GetUnfinishWorkItems,
                "fnServerData": function (sSource, aDataSet, fnCallback) {
                    $.ajax({
                        "dataType": 'json',
                        "type": 'POST',
                        "url": sSource,
                        "data": aDataSet,
                        "success": function (json) {
                            //var jsonRows = [];
                            //$(json.Rows).each(function (index,item) {
                            //    if (item.InstanceName.indexOf('主流程') == -1) {
                            //        jsonRows.push(item);
                            //    }
                            //});
                            //json.Rows = jsonRows;
                            if (json.ExceptionCode == 1 && json.Success == false) {
                                json.Rows = [];
                                json.sEcho = 1;
                                json.Total = 0;
                                json.iTotalDisplayRecords = 0;
                                json.iTotalRecords = 0;
                                $state.go("platform.login");
                            }
                            ////查询添加 编号、简称
                            for (var i = 0; i < json.Rows.length; i++) {
                                $.ajax({
                                    type: "POST",
                                    url: "/Portal/Sheets/Contract/ContractHandler.ashx?Command=getDataByInstanceId",   //处理页的相对地址
                                    data: {
                                        InstanceID: json.Rows[i].InstanceId
                                    },
                                    async: false,
                                    success: function (e) {
                                        json.Rows[i]["OperationNumber"] = e.OperationNumber;
                                        json.Rows[i]["ProjectAbbreviation"] = e.ProjectAbbreviation;
                                    }
                                });
                            }

                            fnCallback(json);
                        }
                    });
                },
                "sAjaxDataProp": 'Rows',
                "sDom": "<'row'<'col-sm-6'l><'col-sm-6'f>r>t<'row'<'col-sm-6'i><'col-sm-6'p>>",
                "sPaginationType": "full_numbers",
                "fnServerParams": function (aoData) {  // 增加自定义查询条件
                    aoData.push({ "name": "keyWord", "value": $scope.searchKey });
                },
                "aoColumns": $scope.getColumns(), // 字段定义
                // 初始化完成事件,这里需要用到 JQuery ，因为当前表格是 JQuery 的插件
                "initComplete": function (settings, json) {
                    var filter = $(".searchContainer");
                    filter.find("button").unbind("click.DT").bind("click.DT", function () {
                        $("#tabUnfinishWorkitem").dataTable().fnDraw();
                    });
                },
                //创建行，未绘画到屏幕上时调用
                "fnRowCallback": function (nRow, aData, iDisplayIndex, iDisplayIndexFull) {
                    //将添加的angular事件添加到作用域中
                    if (aData.ItemSummary != "") {
                        $(nRow).attr("title", aData.ItemSummary);
                        //angular-tooltip暂不可用
                        //$(nRow).attr("tooltips", "");
                        //$(nRow).attr("tooltip-template", aData.ItemSummary);
                        //$(nRow).attr("tooltip-side", "bottom");
                    }
                },
                //datables被draw完后调用
                "fnDrawCallback": function () {
                    jqdatables.trcss();
                    $compile($("#tabUnfinishWorkitem"))($scope);
                    //重新注册
                    $interval.cancel($scope.interval);
                    $scope.registerInterval();
                }
            }
            return options;
        }

        $scope.searchKeyChange = function () {
            if ($scope.searchKey == "")
                $("#tabUnfinishWorkitem").dataTable().fnDraw();
        }

        $scope.registerInterval = function () {
            $scope.interval = $interval(function () {
                $("#tabUnfinishWorkitem").dataTable().fnDraw();
            }, 90 * 1000);
        }

        $scope.$on("$destroy", function () {
            $interval.cancel($scope.interval);
        })
    }]);