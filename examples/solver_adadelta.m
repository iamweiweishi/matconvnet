function [weights, state] = solver_adadelta(weights, state, grad, opts, ~)
%SOLVER_ADADELTA
%   Example AdaDelta solver, for use with CNN_TRAIN and CNN_TRAIN_DAG.

if isempty(state)
  state.g_sqr = 0 ;
  state.delta_sqr = 0 ;
end

rho = opts.rho ;

state.g_sqr = state.g_sqr * rho + grad.^2 * (1 - rho) ;
new_delta = -sqrt((state.delta_sqr + opts.epsilon) ./ ...
                  (state.g_sqr + opts.epsilon)) .* grad ;
state.delta_sqr = state.delta_sqr * rho + new_delta.^2 * (1 - rho) ;

weights = weights + new_delta ;
