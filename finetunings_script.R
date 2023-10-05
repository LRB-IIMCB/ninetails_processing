################################################################################
# Fine Tuning script
# this defines multiple training options at once
################################################################################

# Hyperparameters to check
FLAGS <- tfruns::flags(
  tfruns::flag_string("activation", default = "relu"),
  tfruns::flag_string("kernel_initializer", default = "he_normal"),
  tfruns::flag_string("optimizer", default = "adam"),
  tfruns::flag_numeric("dropout", default = 0.5),
  tfruns::flag_integer("batch_size", default = 100)
)

# Duration (epochs)
eps <- 20


# When to stop the training if validation loss stops drops
early_stop <- keras::callback_early_stopping(monitor="val_loss", patience = 3)

# Print dots for debug purposes
print_dot_callback <- keras::callback_lambda(
  on_epoch_end = function(epoch,logs){
    if (epoch %% 80==0) cat("\n")
    cat(".")
  }
)

# Model definition
ninetails_model <- keras::keras_model_sequential() %>%
  keras::layer_conv_2d(filters=32, kernel_size=c(5,5), activation=FLAGS$activation,
                input_shape =c(100,100,2), kernel_initializer=FLAGS$kernel_initializer,
                padding="valid") %>%
  keras::layer_batch_normalization() %>%
  keras::layer_activation_relu() %>%
  keras::layer_max_pooling_2d(pool_size=c(2,2)) %>%
  keras::layer_dropout(FLAGS$dropout) %>%
  keras::layer_conv_2d(filters=32, kernel_size = c(5,5), activation = FLAGS$activation,
                kernel_initializer = FLAGS$kernel_initializer, padding="valid") %>%
  keras::layer_batch_normalization() %>%
  keras::layer_activation_relu() %>%
  keras::layer_max_pooling_2d(pool_size=c(2,2)) %>%
  keras::layer_dropout(FLAGS$dropout) %>%
  keras::layer_conv_2d(filters=64, kernel_size = c(3,3), activation = FLAGS$activation,
                kernel_initializer = FLAGS$kernel_initializer, padding="same")%>%
  keras::layer_batch_normalization()%>%
  keras::layer_activation_relu() %>%
  keras::layer_max_pooling_2d(pool_size=c(2,2)) %>%
  keras::layer_dropout(FLAGS$dropout) %>%
  keras::layer_conv_2d(filters=128, kernel_size = c(3,3), activation = FLAGS$activation,
                kernel_initializer = FLAGS$kernel_initializer, padding="same")%>%
  keras::layer_batch_normalization()%>%
  keras::layer_activation_relu() %>%
  keras::layer_max_pooling_2d(pool_size=c(2,2)) %>%
  keras::layer_dropout(FLAGS$dropout) %>%
  keras::layer_flatten() %>%
  keras::layer_dense(units=4, activation="softmax")


ninetails_model %>% compile(
  optimizer = FLAGS$optimizer,
  loss = "sparse_categorical_crossentropy",
  metrics = "accuracy"
)

# summary(ninetails_model)

# Fit the model
history <- ninetails_model %>% fit(x=train_dataset_cnn$x,
                                   y=train_dataset_cnn$y,
                                   validation_data = list(validation_dataset_cnn$x,
                                                          validation_dataset_cnn$y),
                                   epochs = eps,
                                   batch_size = FLAGS$batch_size,
                                   view_metrics = TRUE,
                                   verbose = 2,
                                   callbacks = list(early_stop,
                                                    print_dot_callback,
                                                    callback_reduce_lr_on_plateau(factor = 0.05)))

