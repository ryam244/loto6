class PredictionRequest {
  final List<int> ngNumbers;
  final double freqWeight;
  final double sleepWeight;
  final bool excludeLatest;
  final int outputCount;

  PredictionRequest({
    required this.ngNumbers,
    required this.freqWeight,
    required this.sleepWeight,
    required this.excludeLatest,
    required this.outputCount,
  });

  Map<String, dynamic> toJson() => {
        'ng_numbers': ngNumbers,
        'freq_weight': freqWeight,
        'sleep_weight': sleepWeight,
        'exclude_latest': excludeLatest,
        'output_count': outputCount,
      };
}

class PredictionResponse {
  final List<List<int>> predictions;

  PredictionResponse({required this.predictions});

  factory PredictionResponse.fromJson(Map<String, dynamic> json) {
    List<List<int>> preds =
        (json['predictions'] as List).map((e) => List<int>.from(e)).toList();
    return PredictionResponse(predictions: preds);
  }
}
