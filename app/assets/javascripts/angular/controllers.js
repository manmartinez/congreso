var controllers = angular.module('congreso.controllers',[]);

controllers.controller('QuestionsCtrl', ['$scope', '$http', '$interval', function($scope, $http, $interval){
    $scope.questions = [];
    $scope.search = {};

    loadQuestions();
    PrivatePub.subscribe('/questions', function(data, channel){
        $scope.questions.push(data.question);
        $scope.$apply();
    });

    $interval(loadQuestions, 3000);

    
    function loadQuestions() {
        $http.get('http://programacionparalela.com:8083/api/questions.json', {
            headers: {
                'Authorization': 'Token token=' + '97baa43c6bd2b9ead17bd1b801442167'
            }
        }).success(function(data, status){
            $scope.questions = data;
        }).error(function(data, status) {
            console.log('Algo salió mal');
            console.log(data);
        });
    }
    
}]);