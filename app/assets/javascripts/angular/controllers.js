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
        $http.get('http://192.168.0.183:3000/api/questions.json', {
            headers: {
                'Authorization': 'Token token=' + 'b35778857fe5f70cd2edd7a3e8dd1d57'
            }
        }).success(function(data, status){
            $scope.questions = data;
        }).error(function(data, status) {
            console.log('Algo salió mal');
            console.log(data);
        });
    }
    
}]);